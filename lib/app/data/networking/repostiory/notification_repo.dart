import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/notification_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class NotificationRepo {
  final ApiServices _apiServices = ApiServices();
  Future<List<NotificationList>?> notificationListRepo(final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getNotificationList(
            userID.toString(), nextID, token.toString());
        return response.when(
          success: (body) {
            final notiData = NotificationModel.fromJson(body);
            if (notiData.status == 'success') {
              return notiData.notificationList;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${notiData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("History Failed: ${error.toString()}");
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
