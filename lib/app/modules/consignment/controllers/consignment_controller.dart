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

  var consignmentList = <ShipmentDatum>[].obs;

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
      if (success != null) {
        consignmentList.value = success;
        // filteredDeliveryList.value = success;
        isConsigementLoading.value = Status.success;
      } else {
        Utils().logInfo('No congiment Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      consignmentList.value = [];
      // filteredDeliveryList.value = [];
      isConsigementLoading.value = Status.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
