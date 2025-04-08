import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:get/get.dart';

class ShipnowController extends GetxController {
  //TODO: Implement ShipnowController
  final shipNowRepo = ShipnowRepo();

  final shipmentDataList = <ShipmentDatum>[].obs;

  final isLoadingShipNow = false.obs;

  Future<void> fetchShipmentData(String nextID) async {
    try {
      isLoadingShipNow(true);
      final data = await shipNowRepo.customerListRepo(
          nextID, '', '', '', '', '', '', '', '', '', '');
      shipmentDataList.value = data ?? [];
    } catch (e) {
      shipmentDataList.value = [];
      Utils().logError(
        'Customer fetch failed $e',
      );
    } finally {
      isLoadingShipNow(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchShipmentData('1');
    super.onInit();
  }
}
