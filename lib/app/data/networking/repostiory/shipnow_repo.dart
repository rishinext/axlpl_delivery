import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ShipnowRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<ShipmentDatum>?> customerListRepo(
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
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getShipmentDataList(
          token,
          userID,
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
            final shipmentModel = ShipmentDataModel.fromJson(body);

            final List<Shipment>? shipmentList = shipmentModel.shipment;

            if (shipmentList != null &&
                shipmentList.isNotEmpty &&
                shipmentList[0].message == 'Success') {
              return shipmentList[0].shipmentData;
            } else {
              throw Exception(
                  "API Error: ${shipmentList?[0].message ?? 'Unknown'}");
            }
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
