import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/models/profile_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ProfileRepo {
  final ApiServices _apiServices = ApiServices();

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      final role = userData?.role.toString();
      log("roles profile data ${role.toString()}");
      // Check if user is available
      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.changePassword(userID, oldPassword,
            newPassword, role.toString(), token.toString());

        return response.when(
          success: (body) {
            // Handle success from the API
            final passwordStatus = CommonModel.fromJson(body);
            // Check password change status
            if (passwordStatus.status != "success") {
              throw Exception(passwordStatus.message ??
                  "ChangePassword Failed: Unknown Error");
            }
            return true; // Password change was successful
          },
          error: (error) {
            throw Exception("ChangePassword Failed: ${error.toString()}");
          },
        );
      } else {
        Utils.instance.log("change password Failed: UserID not found");
        return false; // User ID not found
      }
    } catch (e) {
      Utils.instance.log("Error changing password: $e");
      return false; // Return false in case of an error
    }
  }

  Future<dynamic> editProfile() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      final role = userData?.role?.toString();

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getProfile(userID, role ?? '');

        return response.when(
          success: (body) {
            if (role == 'customer') {
              final customerData = body['Customerdetail'];
              if (customerData != null) {
                return Customerdetail.fromJson(customerData);
              }
            } else if (role == 'messanger') {
              final messengerData = body['Messangerdetail'];
              if (messengerData != null) {
                return MessangersDetailsModel.fromJson(body);
              }
            }

            return null;
          },
          error: (error) {
            throw Exception("EditProfile Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils.instance.log("Error in editProfile: $e");
    }
    return null;
  }

  Future<bool> updateProfile(
    String name,
    String email,
    String phone,
    final photo,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final role = userData?.role?.toString();
      log("roles profile data ${role.toString()}");

      if (userID != null && userID.isNotEmpty) {
        dynamic photoToSend;

        if (photo is File) {
          photoToSend = await MultipartFile.fromFile(
            photo.path,
            filename: photo.path.split('/').last,
          );
        } else if (photo is String) {
          photoToSend = photo;
        } else {
          photoToSend = null;
        }

        final response = await _apiServices.updateProfile(
          userID,
          role.toString(),
          name,
          email,
          phone,
          photoToSend,
        );

        log(photoToSend.toString());
        return response.when(
          success: (body) {
            final updateProfileData = CommonModel.fromJson(body);
            if (updateProfileData.status != "success") {
              throw Exception(updateProfileData.message ??
                  "UpdateProfile Failed: Unknown Error");
            } else {
              Utils.instance
                  .log("UpdateProfile Success: ${updateProfileData.message}");
            }
            return true;
          },
          error: (error) {
            throw Exception("UpdateProfile Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils.instance.log("Error in updateProfile: $e");
    }
    return false;
  }

  Future<bool> rateMessangerRepo(
    final shipmentID,
    final rate,
    final feedback,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      // final token =
      //     userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.rateMessanger(
          userID,
          shipmentID,
          rate,
          feedback,
        ); // Pass token

        return response.when(success: (body) {
          final data = CommonModel.fromJson(body);
          if (data.status != "success") {
            throw Exception(data.message ?? "Rating Failed: Unknown Error");
          } else {
            Utils.instance.log("Rating Success: ${data.message}");
          }
          return true;
        }, error: (error) {
          throw Exception("Rating Failed: ${error.toString()}");
        });
      }
    } catch (e) {
      Utils.instance.log("Error in rating: $e");
    }
    return false;
  }
}
