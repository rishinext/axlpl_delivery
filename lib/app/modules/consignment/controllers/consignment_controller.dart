import 'package:get/get.dart';

class ConsignmentController extends GetxController {
  //TODO: Implement ConsignmentController

  RxInt isSelected = 0.obs;

  var selectedSourceBranch = Rxn<String>();
  var selectedDestinationBranch = Rxn<String>();

  List<String> branches = ["Branch A", "Branch B", "Branch C"];

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
