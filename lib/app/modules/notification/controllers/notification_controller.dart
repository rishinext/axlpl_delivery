import 'package:axlpl_delivery/app/data/models/notification_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/notification_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  final notiRepo = NotificationRepo();

  var isNotificationLoading = Status.initial.obs;
  var isPaginationLoading = false.obs;
  final notiList = <NotificationList>[].obs;

  // Pagination variables
  var currentPage = 1.obs;
  var hasMoreData = true.obs;
  final ScrollController scrollController = ScrollController();

  Future<void> getNotiData(final nextID, {bool isLoadMore = false}) async {
    if (!isLoadMore) {
      isNotificationLoading.value = Status.loading;
    } else {
      isPaginationLoading.value = true;
    }

    try {
      final success = await notiRepo.notificationListRepo(nextID);
      if (success != null) {
        if (isLoadMore) {
          // Add new data to existing list
          notiList.addAll(success);
        } else {
          // Replace existing data
          notiList.value = success;
        }

        // Check if we have more data (assuming API returns less than expected means no more data)
        if (success.length < 10) {
          // Adjust this number based on your API's page size
          hasMoreData.value = false;
        }

        isNotificationLoading.value = Status.success;
      } else {
        if (!isLoadMore) {
          Utils().logInfo('No Notifications Record Found!');
        }
        hasMoreData.value = false;
      }
    } catch (e) {
      Utils().logError(e.toString());
      if (!isLoadMore) {
        notiList.value = [];
        isNotificationLoading.value = Status.error;
      }
      hasMoreData.value = false;
    } finally {
      isPaginationLoading.value = false;
    }
  }

  void loadMoreData() {
    if (!isPaginationLoading.value && hasMoreData.value) {
      currentPage.value++;
      getNotiData(currentPage.value.toString(), isLoadMore: true);
    }
  }

  void refreshData() {
    currentPage.value = 1;
    hasMoreData.value = true;
    getNotiData('1', isLoadMore: false);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreData();
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getNotiData('1');
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}
