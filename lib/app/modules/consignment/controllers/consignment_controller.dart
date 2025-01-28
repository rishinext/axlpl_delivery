import 'package:get/get.dart';

class ConsignmentController extends GetxController {
  //TODO: Implement ConsignmentController
  RxString showConsiment = 'showConsiment'.obs;

  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;
  RxInt isSelected = 0.obs;

  var selectedSourceBranch = Rxn<String>();
  var selectedDestinationBranch = Rxn<String>();

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
}
