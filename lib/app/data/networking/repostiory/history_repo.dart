import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/history_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class HistoryRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<HistoryDelivery>?> historyRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final token = userData?.messangerdetail?.token;
      final branchID = userData?.messangerdetail?.branchId;
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getDeliveryHistory(
            userID.toString(), branchID.toString(), token.toString());
        return response.when(
          success: (body) {
            final historyData = HistoryModel.fromJson(body);
            if (historyData.status == success) {
              return historyData.historyDelivery;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${historyData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("History Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError("$e", 'API Logout Error');
    }
    return null;
  }

  Future<List<HistoryDelivery>?> pickupHistoryRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final token = userData?.messangerdetail?.token;
      final branchID = userData?.messangerdetail?.branchId;
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getPickupHistory(
            userID.toString(), branchID.toString(), token.toString());
        return response.when(
          success: (body) {
            final historyData = HistoryModel.fromJson(body);
            if (historyData.status == success) {
              return historyData.historyDelivery;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${historyData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Pickup History Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError("$e", 'API Logout Error');
    }
    return null;
  }
}
