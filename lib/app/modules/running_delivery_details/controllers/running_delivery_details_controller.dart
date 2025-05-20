import 'package:axlpl_delivery/app/data/models/stepper_model.dart';
import 'package:axlpl_delivery/app/data/models/tracking_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/tracking_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunningDeliveryDetailsController extends GetxController {
  //TODO: Implement RunningDeliveryDetailsController

  var currentStep = 0.obs;
  final TrackingRepo repo = TrackingRepo();

  var trackingStatusList = <TrackingStatusList>[].obs;

  var trackingStatus = <dynamic>[].obs;
  var senderData = <dynamic>[].obs;
  var receiverData = <dynamic>[].obs;

  var isTrackingLoading = Status.initial.obs;

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

  Future<void> fetchTrackingData(String shipmentID) async {
    try {
      final trackingData =
          await repo.trackingRepo(shipmentID); // <-- from your repo
      final trackingList = trackingData?.tracking ?? [];

      trackingStatus.value = _extractSection(trackingList, 'TrackingStatus');
      senderData.value = _extractSection(trackingList, 'SenderData');
      receiverData.value = _extractSection(trackingList, 'ReceiverData');
    } catch (e) {
      Utils().logError(e.toString());
    }
  }

  List<dynamic> _extractSection(List<dynamic> list, String key) {
    final section = list.firstWhere(
      (item) => item is Map<String, dynamic> && item.containsKey(key),
      orElse: () => <String, dynamic>{},
    );
    return section[key] ?? [];
  }
}
