import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ShipnowRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<ShipmentDataList>?> customerListRepo(final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      if (userID != null && userID.isNotEmpty) {
        final response =
            await _apiServices.getShipmentDataList(userID.toString(), nextID);
        return response.when(
          success: (body) {
            final shipmentData = Shipment.fromJson(body);
            if (shipmentData.message == 'Success') {
              return shipmentData.shipmentData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${shipmentData.code}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Shipment Data Failed: ${error.toString()}");
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
