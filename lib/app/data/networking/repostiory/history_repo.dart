import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/history_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';

class HistoryRepository {
  final ApiServices _apiServices = ApiServices();

  /* Future<List<HistoryDelivery>> historyRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final token = userData?.messangerdetail?.token;
final branch 
      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getDeliveryHistory(
            userID.toString(), branchID, zipcode, token);
      }
    } catch (e) {
      print(e);
    }
  }*/
}
