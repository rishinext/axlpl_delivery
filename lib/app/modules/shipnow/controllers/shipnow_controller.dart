import 'dart:isolate';
import 'dart:ui';
import 'package:axlpl_delivery/app/data/models/shipnow_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:axlpl_delivery/utils/theme.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ShipnowController extends GetxController {
  final themes = Themes();
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
          nextID, '', '', '', '', '', '', '', '', '', '');

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

  final ReceivePort _port = ReceivePort();

  @override
  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);

      if (status == DownloadTaskStatus.complete) {
        Fluttertoast.showToast(
            msg: "Label downloaded successfully Please check your downloads",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: themes.darkCyanBlue,
            textColor: themes.whiteColor,
            fontSize: 16.0);
      } else if (status == DownloadTaskStatus.failed) {
        Fluttertoast.showToast(
            msg: "Label download failed",
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: themes.redColor,
            textColor: themes.whiteColor,
            fontSize: 16.0);
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);
    shipmentIDController.addListener(() {
      filterShipmentData(shipmentIDController.text);
    });

    fetchShipmentData('0', isRefresh: true);
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    shipmentIDController.dispose();
    super.onClose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> downloadShipmentLable(String url, String fileName) async {
    isDownloadingLabel.value = true;
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
        saveInPublicStorage: true, // Fix for public storage download
        fileName: '$fileName lable.pdf',
      );
      Fluttertoast.showToast(
          msg: "Lebel Downloading started",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: themes.darkCyanBlue,
          textColor: themes.whiteColor,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Failed to start download",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: themes.redColor,
          textColor: themes.whiteColor,
          fontSize: 16.0);
      // Optionally show a snackbar or dialog here
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
}
