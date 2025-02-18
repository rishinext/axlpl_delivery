import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeRepository {
  final ApiServices _apiServices = ApiServices();
  final Utils _utils = Utils();
  final deviceId = MobileDeviceIdentifier().getDeviceId();

  Future<DashboardDataModel?> dashboardDataRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final token = userData?.messangerdetail?.token;
      final branchID = userData?.messangerdetail?.branchId;
      final fcmToken = _utils.fcmToken;
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = "${packageInfo.version}-${packageInfo.buildNumber}";
      if (userID != null && userID.isNotEmpty) {
        Utils().logInfo(
            "Calling API with: userID=$userID, branchID=$branchID, token=$token");
        final response = await _apiServices.getDashboardData(
          userID,
          branchID.toString(),
          token ?? "",
          fcmToken ?? "",
          appVersion,
          deviceId.toString(),
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
            Utils()
                .logError(error.toString(), 'Dashboard Data API Call Failed!');
            return null;
          },
        );
      } else {
        Utils().logError("Error", 'UserID Not Found!');
      }
    } catch (e) {
      Utils().logError("$e", 'API Logout Error');
    }
    return null;
  }
}
