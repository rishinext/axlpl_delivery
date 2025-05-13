import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class HomeRepository {
  final ApiServices _apiServices = ApiServices();

  final LocalStorage _localStorage = LocalStorage();
  Future<DashboardDataModel?> dashboardDataRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        Utils().logInfo(
            "Calling API with: userID=$userID, branchID=$branchID, token=$token");
        final response = await _apiServices.getDashboardData(
          userID,
          branchID.toString(),
          token ?? "",
        );
        response.when(
          success: (data) {
            final dashboardData = DashboardDataModel.fromJson(data);
            if (dashboardData.status == success) {
              return dashboardData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${dashboardData.status}');
              return null;
            }
          },
          error: (error) {
            Utils().logError(
              error.toString(),
            );
            return null;
          },
        );
      } else {
        Utils().logError(
          "Error",
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
