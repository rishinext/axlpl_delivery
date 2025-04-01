import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
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
  final serviceTypeList = <ServiceTypeList>[].obs;
  final areaList = <AreaList>[].obs;
  final areaListDiff = <AreaList>[].obs;
  var pincodeDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var pincodeDataDiff = Rxn<GetPincodeDetailsModel>(null);
  final paymentModes = [
    {'id': '1', 'name': 'Prepaid'},
    {'id': '2', 'name': 'To Pay'},
  ].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> expireDate = DateTime.now().obs;
  final PageController pageController = PageController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController netWeightController = TextEditingController();
  final TextEditingController grossWeightController = TextEditingController();
  final TextEditingController noOfParcelController = TextEditingController();
  final TextEditingController policyNoController = TextEditingController();
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController insuranceValueController =
      TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final TextEditingController senderInfoNameController =
      TextEditingController();
  final TextEditingController senderInfoCompanyNameController =
      TextEditingController();
  final TextEditingController senderInfoZipController = TextEditingController();
  final TextEditingController diffrentZipController = TextEditingController();

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
  final isLoadingPincode = false.obs;
  final isLoadingDiffPincode = false.obs;
  final isLoadingArea = false.obs;
  final isLoadingDiffArea = false.obs;

  var selectedCustomer = Rxn<String>();

  var selectedCategory = Rxn<String>();

  var selectedCommodity = Rxn<String>();

  var selectedServiceType = Rxn<String>();

  var selectedArea = Rxn<String>();
  var selectedDiffrentArea = Rxn<String>();

  var selectedPaymentModeId = Rxn<String>();

  RxString insuranceType = 'NO'.obs;
  RxString diffrentAddressType = 'NO'.obs;
  RxString addressType = 'New Address'.obs;
  var currentPage = 0.obs;
  RxInt totalPage = 5.obs;
  final errorMessage = RxString('');

  Future<void> fetchCustomers([String nextID = '']) async {
    try {
      isLoadingCustomers(true);
      final data = await addShipmentRepo.customerListRepo('', nextID);
      customerList.value = data ?? [];
    } catch (e) {
      customerList.value = [];
      Utils().logError(
        'Customer fetch failed $e',
      );
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
      Utils().logError(
        'Error getting customers $error',
      );
    } finally {
      isLoadingCate(false);
    }
  }

  Future commodityListData(final cateID) async {
    if (cateID.isEmpty) return;
    try {
      isLoadingCommodity(true);
      selectedCommodity.value = null;
      commodityList.value = [];
      final data = await addShipmentRepo.commodityListRepo('', cateID);
      if (data == null || data.isEmpty) {
        commodityList.value = [];
        Utils().logInfo('No commodities found for category $cateID');
        return;
      } else {
        commodityList.value = data;
      }
      commodityList.value = data;
    } catch (error) {
      commodityList.value = [];
      Utils().logError(
        'Error getting customers $error',
      );
    } finally {
      isLoadingCommodity(false);
      commodityList.refresh();
    }
  }

  Future<void> fetchServiceType() async {
    try {
      isServiceType(true);
      final data = await addShipmentRepo.serviceTypeListRepo();
      serviceTypeList.value = data ?? [];
    } catch (e) {
      serviceTypeList.value = [];
      Utils().logError(
        'service fetch failed $e',
      );
    } finally {
      isServiceType(false);
    }
  }

  Future<void> fetchPincodeDetailsSenderInfo(String pincode) async {
    errorMessage.value = '';
    try {
      isLoadingPincode.value = true;

      final response = await addShipmentRepo.pincodeDetailsRepo(pincode);

      if (response != null &&
          response.stateName != null &&
          response.cityName != null) {
        pincodeDetailsData.value = response;
      } else {
        pincodeDetailsData.value = null; // clear invalid data
        errorMessage.value = 'Invalid pincode!';
      }
    } catch (e) {
      pincodeDetailsData.value = null;
      errorMessage.value = 'Pincode fetch failed!';
      Utils().logError(
        'Pincode Fetch Failed $e',
      );
    } finally {
      isLoadingPincode.value = false;
    }
  }

  Future<void> fetchPincodeDetailsDiff(String pincode) async {
    errorMessage.value = '';
    try {
      isLoadingDiffPincode.value = true;

      final response = await addShipmentRepo.pincodeDetailsRepo(pincode);

      if (response != null &&
          response.stateName != null &&
          response.cityName != null) {
        pincodeDataDiff.value = response;
      } else {
        pincodeDataDiff.value = null; // clear invalid data
        errorMessage.value = 'Invalid pincode!';
      }
    } catch (e) {
      pincodeDataDiff.value = null;
      errorMessage.value = 'Pincode fetch failed!';
      Utils().logError(
        'Pincode Fetch Failed $e',
      );
    } finally {
      isLoadingDiffPincode.value = false;
    }
  }

  Future fetchAeraByZipData(final zip) async {
    if (senderInfoZipController.text.isEmpty) return;
    try {
      isLoadingArea(true);
      selectedCommodity.value = null;
      areaList.value = [];
      final data = await addShipmentRepo.allAeraByZipRepo(zip);
      if (data == null || data.isEmpty) {
        areaList.value = [];
        Utils().logInfo('No Aera found ${senderInfoZipController.text}');
        return;
      } else {
        areaList.value = data;
      }
      areaList.value = data;
    } catch (error) {
      areaList.value = [];
      Utils().logError(
        'Error getting customers $error',
      );
    } finally {
      isLoadingArea(false);
    }
  }

  Future fetchAeraByZipDataDiff(final zip) async {
    if (diffrentZipController.text.isEmpty) return;
    try {
      isLoadingDiffArea(true);

      areaListDiff.value = [];
      final data = await addShipmentRepo.allAeraByZipRepo(zip);
      if (data == null || data.isEmpty) {
        areaListDiff.value = [];

        Utils().logInfo('No Aera found ${diffrentZipController.text}');
        return;
      } else {
        areaListDiff.value = data;
      }
      areaListDiff.value = data;
    } catch (error) {
      areaListDiff.value = [];
      Utils().logError(
        'Error getting customers $error',
      );
    } finally {
      isLoadingDiffArea(false);
    }
  }

  Future<void> pickDate(BuildContext context, [final selectDate]) async {
    final DateTime? pickedDate = await holoDatePicker(
      context,
      initialDate: selectDate.value,
      firstDate: DateTime(2000), // Adjust as needed
      lastDate: DateTime(2100), // Adjust as needed
      hintText: "Choose Start Date",
    );

    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate; // Update the selected date
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
    fetchServiceType();
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
