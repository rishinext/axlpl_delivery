import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ShipnowRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<ShipmentDataList>?> customerListRepo(
      final nextID,
      final shimentStatus,
      final receiverGSTNo,
      final senderGSTNo,
      final receiverAeraName,
      final senderAeraName,
      final destination,
      final orgin,
      final receiverCompanyName,
      final senderCompanyName,
      final shipmentID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getShipmentDataList(
          userID.toString(),
          nextID,
          shimentStatus,
          receiverGSTNo,
          senderGSTNo,
          receiverAeraName,
          senderAeraName,
          destination,
          orgin,
          receiverCompanyName,
          senderAeraName,
          shipmentID,
        );
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
