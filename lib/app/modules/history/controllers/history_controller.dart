import 'package:get/get.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  RxInt isSelected = 0.obs;

  void selectedContainer(int index) {
    isSelected.value = index;
  }
}
