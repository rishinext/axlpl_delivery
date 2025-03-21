import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/datat_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/add_shipment_repo.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_different_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_payment_info_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddShipmentController extends GetxController {
  //TODO: Implement AddShipmentController

  final addShipmentRepo = AddShipmentRepo();

  final customerList = <CustomersList>[].obs;
  final categoryList = <CategoryList>[].obs;
  final commodityList = <CommodityList>[].obs;
  final paymentModes = [
    {'id': '1', 'name': 'Prepaid'},
    {'id': '2', 'name': 'To Pay'},
  ].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  final PageController pageController = PageController();
  final TextEditingController searchController = TextEditingController();

  List<Widget> shipmentList = [
    AddShipmentView(),
    AddAddressView(),
    AddDifferentAddressView(),
    AddPaymentInfoView()
  ];

  final isLoadingCustomers = false.obs;
  final isLoadingCate = false.obs;
  final isLoadingCommodity = false.obs;
  final isServiceType = false.obs;

  var selectedCustomer = Rxn<String>();

  var selectedCategory = Rxn<String>();

  var selectedCommodity = Rxn<String>();

  var selectedServiceType = Rxn<String>();

  var selectedPaymentModeId = Rxn<String>();

  RxString insuranceType = 'NO'.obs;
  RxString diffrentAddressType = 'NO'.obs;
  RxString addressType = 'New Address'.obs;
  var currentPage = 0.obs;
  RxInt totalPage = 5.obs;
  Future<void> fetchCustomers([String nextID = '']) async {
    try {
      isLoadingCustomers(true);
      final data = await addShipmentRepo.customerListRepo('', nextID);
      customerList.value = data ?? [];
    } catch (e) {
      customerList.value = [];
      Utils().logError('Customer fetch failed', e);
    } finally {
      isLoadingCustomers(false);
    }
  }

  Future categoryListData() async {
    try {
      isLoadingCate(true);
      final data = await addShipmentRepo.categoryListRepo('');
      categoryList.value = data ?? [];
    } catch (error) {
      categoryList.value = [];
      Utils().logError('Error getting customers', error);
    } finally {
      isLoadingCate(false);
    }
  }

  Future commodityListData(final cateID) async {
    if (cateID == null) return;
    try {
      isLoadingCommodity(true);
      selectedCommodity.value = null;
      commodityList.value = [];
      final data = await addShipmentRepo.commodityListRepo('', cateID);
      commodityList.value = data ?? [];
    } catch (error) {
      commodityList.value = [];
      Utils().logError('Error getting customers', error);
    } finally {
      isLoadingCommodity(false);
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
    fetchCustomers('0');
    categoryListData();
    paymentModes.refresh();
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
