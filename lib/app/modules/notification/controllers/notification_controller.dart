import 'package:axlpl_delivery/app/data/models/notification_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/notification_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  final notiRepo = NotificationRepo();

  var isNotificationLoading = Status.initial.obs;
  final notiList = <NotificationList>[].obs;

  Future<void> getNotiData(final nextID) async {
    isNotificationLoading.value = Status.loading;
    try {
      final success = await notiRepo.notificationListRepo(nextID);
      if (success != null) {
        notiList.value = success;

        isNotificationLoading.value = Status.success;
      } else {
        Utils().logInfo('No Notifications Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      notiList.value = [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    getNotiData('1');
  }
}
