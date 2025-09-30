import 'dart:developer';
import 'dart:io';
import 'package:axlpl_delivery/app/data/networking/api_exception.dart';
import 'package:axlpl_delivery/app/data/networking/api_response.dart';
import 'package:axlpl_delivery/app/data/networking/interceptor/dio_connectivity_request_retry.dart';
import 'package:axlpl_delivery/app/data/networking/interceptor/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

class ApiClient {
  late Dio _dio;
  final String baseUrl = 'https://my.axlpl.com/messenger/services_v7/';

  ApiClient() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.sendTimeout = Duration(seconds: 5);
    _dio.options.connectTimeout = Duration(seconds: 5);
    _dio.options.receiveTimeout = Duration(seconds: 5);
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    if (kDebugMode) {
      _dio.interceptors.add(TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printErrorHeaders: true,
          printRequestHeaders: true,
          printResponseData: true,
          printRequestData: true,
          printResponseHeaders: true,
          printResponseMessage: true,
          printErrorMessage: true,
          printErrorData: true,
        ),
      )

          // PrettyDioLogger(
          //   requestHeader: true,
          //   requestBody: true,
          //   responseBody: true,
          //   responseHeader: false,
          //   error: true,
          //   compact: true,
          //   maxWidth: 90,
          // ),
          );
    }
  }

  Future<APIResponse> post(
    String path,
    dynamic body, {
    String? newBaseUrl,
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.urlEncoded,
  }) async {
    // ✅ Step 1: Check Internet Connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return APIResponse.error(AppException.connectivity());
    }

    // ✅ Step 2: ruct URL
    String url = newBaseUrl != null ? newBaseUrl + path : baseUrl + path;

    // ✅ Step 3: Define Content Type
    var content = contentType == ContentType.json
        ? 'application/json'
        : 'application/x-www-form-urlencoded';

    try {
      // ✅ Step 4: Define Headers
      final headers = {
        'accept': '*/*',
        'Content-Type': content,
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // ✅ Step 5: Make the API Request
      final response = await _dio.post(
        url,
        data: body,
        queryParameters: query,
        options: Options(
          contentType: contentType == ContentType.json
              ? Headers.jsonContentType
              : Headers.formUrlEncodedContentType,
          validateStatus: (status) => true, // Allow handling all status codes
          headers: headers,
        ),
      );

      // ✅ Step 6: Handle Response Codes
      if (response.statusCode == null) {
        debugPrint('Status Code is Null. Response: ${response.toString()}');
        return APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return response.data['data'] != null
            ? APIResponse.success(response.data['data'])
            : APIResponse.success(response.data);
      } else {
        return _handleErrorResponse(response);
      }
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      return APIResponse.error(AppException.errorWithMessage(e.toString()));
    }
  }

  /// ✅ Handles HTTP Errors based on status codes
  APIResponse _handleErrorResponse(Response response) {
    switch (response.statusCode) {
      case 401:
        return APIResponse.error(AppException.unauthorized());
      case 403:
        return APIResponse.error(AppException.forbidden());
      case 404:
        return APIResponse.error(AppException.notFound());
      case 502:
        return APIResponse.error(AppException.badGateway());
      case 500:
        return APIResponse.error(AppException.serverError());
      default:
        final message = response.data['message'] as String?;
        return message != null
            ? APIResponse.error(AppException.errorWithMessage(message))
            : APIResponse.error(AppException.error());
    }
  }

  /// ✅ Handles DioExceptions like timeouts, no internet, etc.
  APIResponse _handleDioException(DioException e) {
    debugPrint('DioException: ${e.toString()}');
    debugPrint('Response Data: ${e.response?.data}');

    if (e.error is SocketException) {
      return APIResponse.error(AppException.connectivity());
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return APIResponse.error(AppException.connectivity());
    }

    final message = e.response?.data['message'] as String?;
    return message != null
        ? APIResponse.error(AppException.errorWithMessage(message))
        : APIResponse.error(AppException.errorWithMessage(e.message ?? ''));
  }

  Future<APIResponse> get(
    String path, {
    String? newBaseUrl,
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.urlEncoded,
  }) async {
    // Check for network connectivity with potential error handling
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return APIResponse.error(AppException.connectivity());
      }
    } catch (e) {
      log("Connectivity check failed: ${e.toString()}");
      return APIResponse.error(
          AppException.errorWithMessage("Connectivity check failed"));
    }

    // Determine the URL to use
    String url = newBaseUrl != null ? newBaseUrl + path : baseUrl + path;

    // Simplify content-type assignment
    final content = contentType == ContentType.json
        ? 'application/json; charset=utf-8'
        : 'application/x-www-form-urlencoded';

    try {
      // Setup headers with an optional authorization token
      final headers = {
        'accept': '*/*',
        'Content-Type': content,
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token'; // Add token if needed
      }

      // Perform the GET request
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      // Handle response based on status code
      if (response.statusCode == null) {
        return APIResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return response.data['data'] != null
            ? APIResponse.success(response.data['data'])
            : APIResponse.success(response.data);
      } else {
        switch (response.statusCode) {
          case 401:
            return APIResponse.error(AppException.unauthorized());
          case 403:
            return APIResponse.error(AppException.forbidden());
          case 404:
            return APIResponse.error(AppException.notFound());
          case 502:
            return APIResponse.error(AppException.badGateway());
          case 500:
            return APIResponse.error(AppException.serverError());
          default:
            final message = response.data['message'] as String?;
            return message != null
                ? APIResponse.error(AppException.errorWithMessage(message))
                : APIResponse.error(AppException.error());
        }
      }
    } on DioException catch (e) {
      // Specific catch blocks with logging
      if (e.error is SocketException) {
        log("SocketException: ${e.message}");
        return APIResponse.error(AppException.connectivity());
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        log("TimeoutException: ${e.message}");
        return APIResponse.error(AppException.connectivity());
      }

      if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        log("BadResponseException: ${e.message}, statusCode: $statusCode");
        final errorMessage =
            e.response?.data['message'] as String? ?? 'Something went wrong.';
        return APIResponse.error(AppException.errorWithMessage(errorMessage));
      }

      if (e.type == DioExceptionType.cancel) {
        log("Request was cancelled: ${e.message}");
        // Return an error or handle it as needed
      }

      log("DioException: ${e.message}");
      return APIResponse.error(AppException.error());
    } catch (e) {
      // Capture any unexpected exceptions
      log("Unexpected error: ${e.toString()}");
      return APIResponse.error(
          AppException.errorWithMessage("Unexpected error occurred"));
    }
  }
}

enum ContentType { urlEncoded, json }
