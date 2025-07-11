import 'dart:io';

import 'package:axlpl_delivery/app/data/models/stepper_model.dart';
import 'package:axlpl_delivery/app/data/models/tracking_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/tracking_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class RunningDeliveryDetailsController extends GetxController {
  //TODO: Implement RunningDeliveryDetailsController

  var currentStep = 0.obs;
  final TrackingRepo repo = TrackingRepo();
  final shipmentDetail = Rxn<ShipmentDetails>();

  // var trackingStatusList = <Tracking>[].obs;

  var trackingStatus = <dynamic>[].obs;
  var senderData = <dynamic>[].obs;
  var receiverData = <dynamic>[].obs;

  var imageFile = Rx<File?>(null);

  var isTrackingLoading = Status.initial.obs;
  var isInvoiceUpload = Status.initial.obs;

  final message = ''.obs;

  var imageMap = <String, File>{}.obs;

  void setImage(String shipmentId, File file) {
    imageMap[shipmentId] = file;
    imageMap.refresh(); // to trigger Obx
  }

  void removeImage(String shipmentId) {
    imageMap.remove(shipmentId);
    imageMap.refresh();
  }

  File? getImage(String shipmentId) {
    return imageMap[shipmentId];
  }

  final List<Map<String, dynamic>> stepsData = [
    {
      "title": "Delivery Attempted",
      "subtitle": "Recipients Address",
      "date": "Today, 12:30",
      "icon": Icons.gps_fixed,
      "hasDriver": true,
      "driverName": "Mr. Biju Dahal",
      "driverImage": "assets/manimg.png", // Add your driver image asset
      "phone": "1234567890"
    },
    {
      "title": "Out for Delivery",
      "subtitle": "Local Delivery Network",
      "date": "January, 31, 2024",
      "icon": Icons.local_shipping
    },
    {
      "title": "In Transit",
      "subtitle": "En Route",
      "date": "January, 31, 2024",
      "icon": Icons.directions_bus
    },
    {
      "title": "Shipment Out for Dispatch",
      "subtitle": "Recipients Address",
      "date": "August, 31, 2024",
      "icon": Icons.local_post_office
    },
    {
      "title": "Order Accepted",
      "subtitle": "Recipients Address",
      "date": "August, 31, 2024",
      "icon": Icons.check_circle
    }
  ];
  Future<void> makingPhoneCall(String phoneNo) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNo);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> pickImage(
      ImageSource source, void Function(File) onPicked) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      onPicked(File(pickedFile.path));
    }
  }

  Future<void> fetchTrackingData(String shipmentID) async {
    isTrackingLoading.value = Status.loading;
    try {
      final trackingData = await repo.trackingRepo(shipmentID);
      final trackingList = trackingData?.tracking ?? [];

      if (trackingList.isNotEmpty) {
        List<TrackingStatus> trackingStatusList = [];
        List<ErDatum> senderDataList = [];
        List<ErDatum> receiverDataList = [];
        ShipmentDetails? shipmentDetails;

        for (var item in trackingList) {
          if (item.trackingStatus != null && item.trackingStatus!.isNotEmpty) {
            trackingStatusList.addAll(item.trackingStatus!);
          }

          // CHANGED: add single object directly
          if (item.senderData != null) {
            senderDataList.add(item.senderData!);
          }

          if (item.receiverData != null) {
            receiverDataList.add(item.receiverData!);
          }

          if (shipmentDetails == null && item.shipmentDetails != null) {
            shipmentDetails = item.shipmentDetails;
          }
        }

        trackingStatus.value = trackingStatusList;
        senderData.value = senderDataList;
        receiverData.value = receiverDataList;
        shipmentDetail.value = shipmentDetails;
        isTrackingLoading.value = Status.success;

        Utils().logInfo("""
      Tracking Data Loaded:
      - Status Events: ${trackingStatusList.length}
      - Sender Data: ${senderDataList.length}
      - Receiver Data: ${receiverDataList.length}
      - Shipment Details: ${shipmentDetails != null ? 'Available' : 'Not Available'}
    """);
      } else {
        _clearAllData();
        isTrackingLoading.value = Status.error;
        Utils().logInfo("No tracking data found for shipment: $shipmentID");
      }
    } catch (e, stackTrace) {
      _clearAllData();
      isTrackingLoading.value = Status.error;
      Utils().logError(
        "Failed to fetch tracking data: ${e.toString()}",
      );
    }
  }

  Future<void> uploadInvoice({
    required String shipmentID,
    required File file,
  }) async {
    try {
      isInvoiceUpload.value = Status.loading;
      message.value = '';

      final result = await repo.uploadInvoiceRepo(
        shipmentID,
        file,
      );

      if (result) {
        isInvoiceUpload.value = Status.success;
        message.value = repo.apiMessage ?? 'Upload Inovice successful';

        Get.snackbar("Success", message.value,
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
        fetchTrackingData(shipmentID);
      } else {
        isInvoiceUpload.value = Status.error;
        message.value = repo.apiMessage ?? 'Upload failed';
        Get.snackbar("Error", message.value,
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      isInvoiceUpload.value = Status.error;
      message.value = 'Unexpected error: $e';
      Get.snackbar(
        "Error",
        message.value,
        backgroundColor: themes.redColor,
      );
    }
  }

  void _clearAllData() {
    trackingStatus.clear();
    senderData.clear();
    receiverData.clear();
    shipmentDetail.value = null;
  }
}
