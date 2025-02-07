import 'dart:io';

import 'package:axlpl_delivery/app/modules/add_shipment/views/add_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_different_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_payment_info_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddShipmentController extends GetxController {
  //TODO: Implement AddShipmentController

  List<Widget> shipmentList = [
    AddShipmentView(),
    AddAddressView(),
    AddDifferentAddressView(),
    AddPaymentInfoView()
  ];

  var selectedCustomer = Rxn<String>();
  RxString insuranceType = 'NO'.obs;
  RxString diffrentAddressType = 'NO'.obs;
  RxString addressType = 'New Address'.obs;
  var currentPage = 0.obs;
  RxInt totalPage = 5.obs;

  final PageController pageController = PageController();

  void nextPage() {
    if (currentPage.value <= 3) {
      // Assuming there are 4 pages (0 to 3)
      currentPage++;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceIn,
      );
    } else {
      Get.back();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }
}
