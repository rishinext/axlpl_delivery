import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupController extends GetxController {
  //TODO: Implement PickupController

  final pickupRepo = PickupRepo();

  final pickupList = <RunningPickUp>[].obs;
  final RxList<RunningPickUp> filteredPickupList = <RunningPickUp>[].obs;

  var isPickupLoading = Status.initial.obs;

  final TextEditingController pincodeController = TextEditingController();

  Future<void> getPickupData() async {
    isPickupLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllPickupRepo('0');
      if (success != null) {
        pickupList.value = success;
        filteredPickupList.value = success;
        isPickupLoading.value = Status.success;
      } else {
        Utils().logInfo('No pickup Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      pickupList.value = [];
      filteredPickupList.value = [];
    }
  }

  void filterByPincode(String query) {
    if (query.isEmpty) {
      filteredPickupList.value = pickupList;
    } else {
      filteredPickupList.value = pickupList
          .where((pickup) => (pickup.pincode ?? '').contains(query.trim()))
          .toList();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPickupData();
  }
}
