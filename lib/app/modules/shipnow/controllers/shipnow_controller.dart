import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class ShipnowController extends GetxController {
  final isDownloadingLabel = false.obs;
  //TODO: Implement ShipnowController
  final shipNowRepo = ShipnowRepo();

  final allShipmentData = <ShipmentDatum>[].obs;
  final filteredShipmentData = <ShipmentDatum>[].obs;

  final isLoadingShipNow = false.obs;
  final isLoadingMore = false.obs;

  final shipmentIDController = TextEditingController();
  final TextEditingController shipmentLabelCountController =
      TextEditingController();

  final Map<String, TextEditingController> shipmentLableControllers = {};

  TextEditingController getLableController(String shipmentId) =>
      shipmentLableControllers.putIfAbsent(
          shipmentId, () => TextEditingController());

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

  Future<void> downloadShipmentLabel(String url) async {
    isDownloadingLabel.value = true;
    try {
      // Request notification permission (Android 13+)
      if (Platform.isAndroid &&
          await DeviceInfoPlugin()
                  .androidInfo
                  .then((info) => info.version.sdkInt) >=
              33) {
        await Permission.notification.request();
      }

      final directory = await getExternalStorageDirectory();
      final savedDir = directory?.path ?? '/storage/emulated/0/Download';

      await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        savedDir: savedDir,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
        fileName:
            'shipment_label_${DateTime.now().millisecondsSinceEpoch}.pdf', // Unique filename
        // Add these notification parameters:

        requiresStorageNotLow: false,
      );
    } catch (e) {
      Utils().logError('Download failed: $e');
      // Show error to user
      Get.snackbar(
          'Download Failed', 'Could not download label: ${e.toString()}');
    } finally {
      isDownloadingLabel.value = false;
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
