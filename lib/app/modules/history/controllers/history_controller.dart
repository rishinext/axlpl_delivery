import 'package:axlpl_delivery/app/data/models/history_delivery_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/delivery_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/history_pickup_model.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final historyRepo = DeliveryRepo(); // assuming you have a repository class
  final historyList = <HistoryDelivery>[].obs;
  final pickUpHistoryList = <HistoryPickup>[].obs;
  final zipcodeController = TextEditingController();

  RxInt isSelected = 0.obs;
  var isDeliveredLoading = Status.initial.obs;
  var isPickedup = Status.initial.obs;

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  Future<void> getDeliveryHistory({final nextID = '0', final zip = '0'}) async {
    isDeliveredLoading.value = Status.loading;

    try {
      final success = await historyRepo.deliveryHistoryRepo(
        zip,
        nextID,
      );

      if (success != null && success.isNotEmpty) {
        historyList.value = success;
        isDeliveredLoading.value = Status.success;
      } else {
        Utils().logInfo('No Delivery History Data Found');
        historyList.value = [];
        isDeliveredLoading.value = Status.error;
      }
    } catch (error) {
      Utils().logError(
        'Error getting history $error',
      );
      historyList.value = [];
      isDeliveredLoading.value = Status.error;
    }
  }

  Future<void> getPickupHistory() async {
    isPickedup.value = Status.loading;

    try {
      final success = await historyRepo.pickupHistoryRepo();

      if (success != null && success.isNotEmpty) {
        pickUpHistoryList.value = success;
        isPickedup.value = Status.success;
      } else {
        Utils().logInfo('No Pickup History Data Found');
        pickUpHistoryList.value = [];
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
    getDeliveryHistory();
    getPickupHistory();
    super.onInit();
  }
}
