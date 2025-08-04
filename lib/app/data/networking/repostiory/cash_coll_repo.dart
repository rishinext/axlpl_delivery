import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/transtion_history_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_response.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class CashCollectionRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<CashLog>?> cashCollRepo(
    final nextID,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID != null && userID.isNotEmpty) {
        final response =
            await _apiServices.getCashCollectionLog(token, nextID, userID);
        return response.when(
          success: (body) {
            final cashLogModel = CashCollectionLogModel.fromJson(body);

            return cashLogModel.cashLog;
          },
          error: (error) {
            throw Exception("Shipment Data Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError("Shipment Fetch Exception: $e");
    }
    return [];
  }
}
