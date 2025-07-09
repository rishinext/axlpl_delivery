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
  final isLoadingMore = false.obs;

  final shipmentIDController = TextEditingController();

  // Pagination variables
  int currentPage = 0;
  bool hasMoreData = true;
  static const int pageSize = 10;

  Future<void> fetchShipmentData(String nextID,
      {bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        isLoadingShipNow(true);
        currentPage = 0;
        hasMoreData = true;
      } else {
        isLoadingMore(true);
      }

      final data = await shipNowRepo.customerListRepo(
        nextID,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      );

      final newItems = data ?? [];

      if (isRefresh) {
        allShipmentData.value = newItems;
      } else {
        allShipmentData.addAll(newItems);
      }

      // Check if we have more data
      hasMoreData = newItems.length >= pageSize;

      filterShipmentData(shipmentIDController.text);
    } catch (e) {
      if (isRefresh) {
        allShipmentData.clear();
        filteredShipmentData.clear();
      }
      Utils().logError('Shipment fetch failed $e');
    } finally {
      if (isRefresh) {
        isLoadingShipNow(false);
      } else {
        isLoadingMore(false);
      }
    }
  }

  Future<void> loadMoreData() async {
    if (!hasMoreData || isLoadingMore.value) return;

    currentPage++;
    await fetchShipmentData(currentPage.toString(), isRefresh: false);
  }

  Future<void> refreshData() async {
    await fetchShipmentData('0', isRefresh: true);
  }

  void filterShipmentData(String query) {
    if (query.isEmpty) {
      filteredShipmentData.value = allShipmentData;
    } else {
      filteredShipmentData.value = allShipmentData.where((data) {
        return data.shipmentId!.toLowerCase().contains(query.toLowerCase()) ||
            data.origin!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  @override
  void onInit() {
    shipmentIDController.addListener(() {
      filterShipmentData(shipmentIDController.text);
    });

    fetchShipmentData('0', isRefresh: true);
    super.onInit();
  }

  @override
  void onClose() {
    shipmentIDController.dispose();
    super.onClose();
  }
}
