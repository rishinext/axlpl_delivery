import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/get_ratting_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class HomeRepository {
  final ApiServices _apiServices = ApiServices();

  final LocalStorage _localStorage = LocalStorage();
  Future<DashboardDataModel?> dashboardDataRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        Utils().logInfo(
            "Calling API with: userID=$userID, branchID=$branchID, token=$token");

        final response = await _apiServices.getDashboardData(
          userID,
          branchID.toString(),
          token ?? "",
        );

        DashboardDataModel? result;

        response.when(
          success: (data) {
            final dashboardData = DashboardDataModel.fromJson(data);
            if (dashboardData.status == "success") {
              result = dashboardData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${dashboardData.status}');
            }
          },
          error: (error) {
            Utils().logError("API error: ${error.toString()}");
          },
        );

        return result;
      } else {
        Utils().logError("userID is null or empty");
      }
    } catch (e) {
      Utils().logError("dashboardDataRepo error: $e");
    }

    return null;
  }

  Future<RattingDataModel?> getRattingRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getMessangerRatting(
          userID,
          token.toString(),
        );

        RattingDataModel? result;

        response.when(
          success: (body) {
            log("Raw response body: ${jsonEncode(body)}");
            result = RattingDataModel.fromJson(body); // ✅ parse directly
          },
          error: (error) {
            Utils().logError("Ratting error: $error");
          },
        );

        return result;
      } else {
        Utils().logError("Missing user ID");
      }
    } catch (e) {
      Utils().logError("Exception in getRattingRepo: $e");
    }

    return null;
  }
}
