import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/tracking_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class TrackingRepo {
  final ApiServices _apiServices = ApiServices();

  Future<TrackingModel?> trackingRepo(final shipmentID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      final response = await _apiServices.tracking(
        shipmentID,
        token.toString(),
      );
      return response.when(
        success: (body) {
          final trackingData = TrackingModel.fromJson(body);
          if (trackingData.tracking?[0].error == false) {
            return trackingData;
          } else {
            return throw Exception(trackingData.tracking?[0].error);
          }
        },
        error: (error) {
          throw Exception(error.toString());
        },
      );
    } catch (e) {
      Utils().logError(e.toString());
    }
    return null;
  }
}
