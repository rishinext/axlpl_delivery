import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShipnowController extends GetxController {
  //TODO: Implement ShipnowController
  final shipNowRepo = ShipnowRepo();

  final allShipmentData = <ShipmentDatum>[].obs;
  final filteredShipmentData = <ShipmentDatum>[].obs;

  final isLoadingShipNow = false.obs;

  final shipmentIDController = TextEditingController();

  Future<void> fetchShipmentData(String nextID) async {
    try {
      isLoadingShipNow(true);
      final data = await shipNowRepo.customerListRepo(
          nextID, '', '', '', '', '', '', '', '', '', '');
      allShipmentData.value = data ?? [];
      filterShipmentData(shipmentIDController.text); // apply filter immediately
    } catch (e) {
      allShipmentData.clear();
      filteredShipmentData.clear();
      Utils().logError('Customer fetch failed $e');
    } finally {
      isLoadingShipNow(false);
    }
  }

  void filterShipmentData(String query) {
    if (query.isEmpty) {
      filteredShipmentData.value = allShipmentData;
    } else {
      filteredShipmentData.value = allShipmentData.where((data) {
        // Customize condition according to your data structure:
        // e.g. check shipmentId or origin fields contain the query string (case-insensitive)
        return data.shipmentId!.toLowerCase().contains(query.toLowerCase()) ||
            data.origin!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    shipmentIDController.addListener(() {
      filterShipmentData(shipmentIDController.text);
    });
    fetchShipmentData('1');

    super.onInit();
  }
}
