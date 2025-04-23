import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:get/get.dart';

class PickupController extends GetxController {
  //TODO: Implement PickupController

  final pickupRepo = PickupRepo();

  final pickupList = <RunningPickUp>[].obs;
  final deliveryList = <RunningDelivery>[].obs;

  var isPickupLoading = Status.initial.obs;
  var isDeliveryLoading = Status.initial.obs;

  Future<void> getPickupData() async {
    isPickupLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllPickupRepo('0');
      if (success != null) {
        pickupList.value = success;
        isPickupLoading.value = Status.success;
      } else {
        Utils().logInfo('No pickup Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      pickupList.value = [];
    }
  }

  Future<void> getPiData() async {
    isDeliveryLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllDeliveryRepo('0');
      if (success != null) {
        deliveryList.value = success;
        isDeliveryLoading.value = Status.success;
      } else {
        Utils().logInfo('No delivery Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      deliveryList.value = [];
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPickupData();
    getPiData();
  }
}
