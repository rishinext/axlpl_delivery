import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ProfileRepo {
  final ApiServices _apiServices = ApiServices();

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      final role = userData?.role.toString();

      // Check if user is available
      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.changePassword(userID, oldPassword,
            newPassword, role.toString(), token.toString());

        return response.when(
          success: (body) {
            // Handle success from the API
            final passwordStatus = CommonModel.fromJson(body);
            // Check password change status
            if (passwordStatus.status != "success") {
              throw Exception(passwordStatus.message ??
                  "ChangePassword Failed: Unknown Error");
            }
            return true; // Password change was successful
          },
          error: (error) {
            throw Exception("ChangePassword Failed: ${error.toString()}");
          },
        );
      } else {
        Utils.instance.log("change password Failed: UserID not found");
        return false; // User ID not found
      }
    } catch (e) {
      Utils.instance.log("Error changing password: $e");
      return false; // Return false in case of an error
    }
  }
}
