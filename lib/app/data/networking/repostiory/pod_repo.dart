import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dio/dio.dart';

class PodRepo {
  final ApiServices apiServices = ApiServices();
  final Utils utils = Utils();
  final LocalStorage _localStorage = LocalStorage();
  String? apiMessage;

  String? getApiErrorMessage() {
    return apiMessage;
  }

  Future<bool> profilePhotoUploadRepo(
    String shipmentID,
    String shipmentStatus,
    String shipmentOtp,
    File? file, // Change to File here for better flexibility
  ) async {
    apiMessage = null;

    final userData = await _localStorage.getUserLocalData();
    final userID = userData?.messangerdetail?.id?.toString() ??
        userData?.customerdetail?.id?.toString();
    final token =
        userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

    try {
      MultipartFile? attachment;
      if (file != null) {
        attachment = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
      }

      final response = await apiServices.uploadPOD(
        shipmentID,
        shipmentStatus,
        shipmentOtp,
        attachment,
        token,
      );

      return response.when(
        success: (body) {
          log("API Success Body: $body");
          final apiStatus = CommonModel.fromJson(body);

          if (apiStatus.status != 'success') {
            throw Exception(
                apiStatus.message ?? "Pod Upload Failed: Unknown Error");
          } else {
            apiMessage = apiStatus.message;
          }

          return true;
        },
        error: (exception) {
          throw Exception("Pod Upload Failed: ${exception.toString()}");
        },
      );
    } catch (e) {
      final errorMessage = "Unexpected Error: $e";
      Utils.instance.log(errorMessage);
      return false;
    }
  }
}
