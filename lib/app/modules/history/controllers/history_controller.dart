import 'package:axlpl_delivery/app/data/models/history_dekivery_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/history_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/history_pickup_model.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final historyRepo =
      HistoryRepository(); // assuming you have a repository class
  final historyList = <HistoryDelivery>[].obs;
  final pickUpHistoryList = <HistoryPickup>[].obs;
  final zipcodeController = TextEditingController();

  RxInt isSelected = 0.obs;
  RxBool isLoading = false.obs;
  var isPickedup = Status.initial.obs;

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  Future<void> getHistory(final nextID) async {
    isLoading.value = true;

    try {
      final success = await historyRepo.deliveryHistoryRepo(
        zipcodeController,
        nextID,
      );

      if (success != null) {
        historyList.value = success;
        isLoading.value = false;
      } else {
        Utils().logInfo('No History Data Found');
        isLoading.value = false;
      }
    } catch (error) {
      Utils().logError(
        'Error getting history $error',
      );
      historyList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPickupHistory() async {
    isPickedup.value = Status.loading;

    try {
      final success = await historyRepo.pickupHistoryRepo();

      if (success != null) {
        pickUpHistoryList.value = success;
        isPickedup.value = Status.success;
      } else {
        Utils().logInfo('No Pickup History Data Found');
        isPickedup.value = Status.error;
      }
    } catch (error) {
      Utils().logError(
        'Error getting pickup history $error',
      );
      pickUpHistoryList.value = [];
      isPickedup.value = Status.error;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getHistory('0');
    getPickupHistory();
    super.onInit();
  }
}
