import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  final pickupRepo = PickupRepo();

  //TODO: Implement DeliveryController
  var isDeliveryLoading = Status.initial.obs;

  final deliveryList = <RunningDelivery>[].obs;
  final RxList<RunningDelivery> filteredDeliveryList = <RunningDelivery>[].obs;

  final TextEditingController pincodeController = TextEditingController();

  Future<void> getPiData() async {
    isDeliveryLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllDeliveryRepo('0');
      if (success != null) {
        deliveryList.value = success;
        filteredDeliveryList.value = success;
        isDeliveryLoading.value = Status.success;
      } else {
        Utils().logInfo('No delivery Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      deliveryList.value = [];
      filteredDeliveryList.value = [];
      isDeliveryLoading.value = Status.error;
    }
  }

  void filterByPincode(String query) {
    if (query.isEmpty) {
      filteredDeliveryList.value = deliveryList;
    } else {
      filteredDeliveryList.value = deliveryList
          .where((pickup) => (pickup.pincode ?? '').contains(query.trim()))
          .toList();
    }
  }

  @override
  void onInit() {
    getPiData();
    super.onInit();
  }
}
