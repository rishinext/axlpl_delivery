import 'dart:convert';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/models/lat_long_model.dart';
import 'package:axlpl_delivery/app/data/models/messnager_model.dart';
import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class PickupRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<RunningPickUp>?> getAllPickupRepo(final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getAllPickup(
            userID.toString(), branchID.toString(), nextID, token.toString());
        return response.when(
          success: (body) {
            final pickupData = PickUpModel.fromJson(body);
            if (pickupData.status == success) {
              return pickupData.runningPickUp;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${pickupData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Get All Pickup Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<RunningDelivery>?> getAllDeliveryRepo(final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getAllDelivery(
            userID.toString(), branchID.toString(), nextID, token.toString());
        return response.when(
          success: (body) {
            final runningData = PickUpModel.fromJson(body);
            if (runningData.status == success) {
              return runningData.runningDelivery;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${runningData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Get All Pickup Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<MessangerList>?> getMessangerRepo(final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final userID = userData?.messangerdetail?.id?.toString();

      final routeID = userData?.messangerdetail?.routeId;

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      UserLocation location = await Utils().getUserLocation();

      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getAllMessanger(
          userID.toString(),
          routeID,
          location.latitude,
          location.longitude,
          nextID,
          token,
        );
        return response.when(
          success: (body) {
            final messangerdata = MessangerModel.fromJson(body);
            if (messangerdata.messangersList != null) {
              return messangerdata.messangersList;
            } else {
              Utils()
                  .logInfo('API call successful but status is not "success"');
            }
            return [];
          },
          error: (error) {
            throw Exception("Get Messanger Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<bool?> uploadPickupRepo(
    final shipmentID,
    final shipmentStatus,
    final date,
    final cashAmount,
    final paymentMode,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      UserLocation location = await Utils().getUserLocation();

      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.uploadPickup(
          shipmentID,
          shipmentStatus,
          userID,
          date,
          location.latitude,
          location.longitude,
          cashAmount,
          paymentMode,
          token.toString(),
        );

        bool isSuccess = false;

        response.when(
          success: (body) {
            final data = CommonModel.fromJson(body);
            if (data.status == 'success') {
              Utils().log('pickup done');
              isSuccess = true;
            } else {
              Utils().log('pickup error');
              isSuccess = false;
            }
          },
          error: (error) {
            Utils().logError(error.toString());
            isSuccess = false;
          },
        );

        return isSuccess;
      }
    } catch (e) {
      Utils().logError(e.toString());
      return false;
    }

    return false;
  }

  // Future<List<PaymentMode>?> getPaymentMode() async {
  //   try {
  //     final response = await _apiServices.getPaymentMode();
  //     return response.when(
  //       success: (body) {
  //         // ✅ Don't decode again if already Map
  //         final paymentData = PaymentModeModel.fromJson(body);
  //         if (paymentData.status == 'success') {
  //           return paymentData.data?.paymentModes;
  //         } else {
  //           Utils().logInfo('API call successful but status != success');
  //           return [];
  //         }
  //       },
  //       error: (error) {
  //         throw Exception("Payment Mode Fetch Error: ${error.toString()}");
  //       },
  //     );
  //   } catch (e) {
  //     throw Exception("Exception during fetch: ${e.toString()}");
  //   }
  // }
}
