import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/add_shipment_repo.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_different_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_payment_info_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddShipmentController extends GetxController {
  //TODO: Implement AddShipmentController

  final addShipmentRepo = AddShipmentRepo();

  final customerList = <CustomersList>[].obs;
  final categoryList = <CategoryList>[].obs;
  final commodityList = <CommodityList>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  final PageController pageController = PageController();
  final TextEditingController searchController = TextEditingController();

  List<Widget> shipmentList = [
    AddShipmentView(),
    AddAddressView(),
    AddDifferentAddressView(),
    AddPaymentInfoView()
  ];

  RxBool isLoading = false.obs;
  RxBool isLoadingCate = false.obs;
  var isLoadingMore = false.obs;
  var nextID = "0".obs;
  var selectedCustomer = Rxn<String>();
  var selectedCategory = Rxn<String>();
  RxString insuranceType = 'NO'.obs;
  RxString diffrentAddressType = 'NO'.obs;
  RxString addressType = 'New Address'.obs;
  var currentPage = 0.obs;
  RxInt totalPage = 5.obs;
  Future customersListData(final nextID) async {
    isLoading.value = true;

    try {
      final success = await addShipmentRepo.customerListRepo('', nextID);

      if (success != null) {
        customerList.value = success;
        isLoading.value = false;
      } else {
        Utils().logInfo('No Customers Data Found');
        isLoading.value = false;
      }
    } catch (error) {
      Utils().logError('Error getting customers', error);
      customerList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future categoryListData() async {
    isLoadingCate.value = true;

    try {
      final success = await addShipmentRepo.categoryListRepo('');

      if (success != null) {
        categoryList.value = success;
        isLoadingCate.value = false;
      } else {
        Utils().logInfo('No Customers Data Found');
        isLoadingCate.value = false;
      }
    } catch (error) {
      Utils().logError('Error getting customers', error);
      categoryList.value = [];
    } finally {
      isLoadingCate.value = false;
    }
  }

  Future commodityListData(final cateID) async {
    isLoading.value = true;

    try {
      final success = await addShipmentRepo.commodityListRepo('', cateID);

      if (success != null) {
        commodityList.value = success;
        isLoading.value = false;
      } else {
        Utils().logInfo('No Customers Data Found');
        isLoading.value = false;
      }
    } catch (error) {
      Utils().logError('Error getting customers', error);
      commodityList.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await holoDatePicker(
      context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000), // Adjust as needed
      lastDate: DateTime(2100), // Adjust as needed
      hintText: "Choose Start Date",
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate; // Update the selected date
    }
  }

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
    customersListData('0');
    categoryListData();
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
