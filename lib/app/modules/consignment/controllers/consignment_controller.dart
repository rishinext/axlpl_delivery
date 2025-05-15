import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/congiment_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/congiment_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConsignmentController extends GetxController {
  //TODO: Implement ConsignmentController

  final conRepo = CongimentRepo();
  var isConsigementLoading = Status.initial.obs;

  var consignmentList = <ShipmentDataList>[].obs;

  RxString showConsiment = 'showConsiment'.obs;

  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;
  RxInt isSelected = 0.obs;

  var selectedSourceBranch = Rxn<String>();
  var selectedDestinationBranch = Rxn<String>();
  TextEditingController congimentControllerSearch = TextEditingController();

  List<String> branches = ["Mumbai", "Delhi", "Kolkata"];

  void updateSourceBranch(String value) {
    selectedSourceBranch.value = value;
  }

  void updateDestinationBranch(String value) {
    selectedDestinationBranch.value = value;
  }

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  Future<void> getConsigmentData(final consigmentID) async {
    isConsigementLoading.value = Status.loading;
    try {
      final success = await conRepo.getConsigmentRepo(consigmentID);
      if (success != null && success.isNotEmpty) {
        consignmentList.value = success;
        log("Con list length: ${consignmentList.length}");
        isConsigementLoading.value = Status.success;
      } else {
        consignmentList.value = [];
        isConsigementLoading.value = Status.error;
        Utils().logInfo('No consignment records found!');
      }
    } catch (e) {
      Utils().logError("getConsigmentData Error: $e");
      consignmentList.value = [];
      isConsigementLoading.value = Status.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
