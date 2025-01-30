import 'package:axlpl_delivery/app/data/models/stepper_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunningDeliveryDetailsController extends GetxController {
  //TODO: Implement RunningDeliveryDetailsController

  var currentStep = 0.obs;

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

}
