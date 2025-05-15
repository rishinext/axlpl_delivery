import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/congiment_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class CongimentRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<ShipmentDataList>?> getConsigmentRepo(final congimentID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      // final userID = userData?.messangerdetail?.id?.toString() ??
      //     userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getConsignment(
        congimentID.toString(),
        branchID,
        token.toString(),
      );
      return response.when(success: (body) {
        final parsed = CongismentModel.fromJson(body);
        return parsed.shipment?.first.shipmentData ?? [];
      }, error: (e) {
        throw Exception("Error fetching shipment data: $e");
      });
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return [];
  }
}
