import 'package:axlpl_delivery/app/data/models/congiment_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class CongimentRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<ConsignmentDatum>?> getConsigmentRepo() async {
    try {
      // final userData = await LocalStorage().getUserLocalData();
      // final userID = userData?.messangerdetail?.id?.toString() ??
      //     userData?.customerdetail?.id.toString();
      // final branchID = userData?.messangerdetail?.branchId ??
      //     userData?.customerdetail?.branchId.toString();
      // final token =
      //     userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      final userID = "50";
      if (userID.isNotEmpty) {
        final response = await _apiServices.getConsignment(userID.toString());
        return response.when(
          success: (body) {
            final conData = ConsigmentModel.fromJson(body);
            if (conData.status == success) {
              return conData.consignmentData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${conData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Consignment Failed: ${error.toString()}");
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
