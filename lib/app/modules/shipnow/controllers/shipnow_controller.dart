import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ShipnowController extends GetxController {
  //TODO: Implement ShipnowController
  final shipNowRepo = ShipnowRepo();

  final allShipmentData = <ShipmentDatum>[].obs;
  final filteredShipmentData = <ShipmentDatum>[].obs;

  final isLoadingShipNow = false.obs;
  final isLoadingMore = false.obs;

  final shipmentIDController = TextEditingController();
  final TextEditingController shipmentLabelCountController =
      TextEditingController();

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

  Future<void> downloadShipmentLable(String url) async {
    try {
      final directory = await getExternalStorageDirectory();
      final savedDir = directory?.path ?? '/storage/emulated/0/Download';

      await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: savedDir,
        showNotification:
            true, // show download progress in status bar (Android)
        openFileFromNotification:
            true, // click notification to open file (Android)
      );
    } catch (e) {
      Utils().logError('Download failed: $e');
      // Optionally show a snackbar or dialog here
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
