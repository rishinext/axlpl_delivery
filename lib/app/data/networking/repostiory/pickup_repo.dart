import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class PickupRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<RunningPickUp>?> pickupHistoryRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getPickupHistory(
            userID.toString(), branchID.toString(), token.toString());
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
            throw Exception("Pickup  Failed: ${error.toString()}");
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
}
