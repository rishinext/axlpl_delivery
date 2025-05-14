import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
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
  ShipmentRequestModel shipmentData = ShipmentRequestModel();

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
    {'id': '3', 'name': 'Prepaid Cash'},
    {'id': '4', 'name': 'Topay Cash'},
    {'id': '5', 'name': 'account(contract)'},
  ].obs;
  final subPaymentModes = [
    {'id': '1', 'name': 'Account'},
    {'id': '2', 'name': 'Cash'},
    {'id': '3', 'name': 'Cheque'},
    {'id': '4', 'name': 'Online'},
  ].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> expireDate = DateTime.now().obs;

  final PageController pageController = PageController();

  List<GlobalKey<FormState>> formKeys =
      List.generate(5, (index) => GlobalKey<FormState>());

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

  final TextEditingController senderInfoStateController =
      TextEditingController();

  final TextEditingController senderInfoCityController =
      TextEditingController();
  final TextEditingController senderInfoGstNoController =
      TextEditingController();
  final TextEditingController senderInfoAddress1Controller =
      TextEditingController();
  final TextEditingController senderInfoAddress2Controller =
      TextEditingController();
  final TextEditingController senderInfoMobileController =
      TextEditingController();
  final TextEditingController senderInfoExitingEmailController =
      TextEditingController();
// ✅ Controllers for EXISTING ADDRESS
  final TextEditingController existingSenderInfoNameController =
      TextEditingController();
  final TextEditingController existingSenderInfoCompanyNameController =
      TextEditingController();
  final TextEditingController existingSenderInfoZipController =
      TextEditingController();
  final TextEditingController existingSenderInfoStateController =
      TextEditingController();
  final TextEditingController existingSenderInfoCityController =
      TextEditingController();
  final TextEditingController existingSenderInfoGstNoController =
      TextEditingController();
  final TextEditingController existingSenderInfoAddress1Controller =
      TextEditingController();
  final TextEditingController existingSenderInfoAddress2Controller =
      TextEditingController();
  final TextEditingController existingSenderInfoMobileController =
      TextEditingController();
  final TextEditingController existingSenderInfoEmailController =
      TextEditingController();
  final TextEditingController existingSenderInfoAreaController =
      TextEditingController();

  final TextEditingController receiverInfoNameController =
      TextEditingController();
  final TextEditingController receiverInfoCompanyNameController =
      TextEditingController();
  final TextEditingController receiverInfoZipController =
      TextEditingController();

  final TextEditingController receiverInfoStateController =
      TextEditingController();
  final TextEditingController receiverInfoCityController =
      TextEditingController();
  final TextEditingController receiverInfoGstNoController =
      TextEditingController();
  final TextEditingController receiverInfoAddress1Controller =
      TextEditingController();
  final TextEditingController receiverInfoAddress2Controller =
      TextEditingController();
  final TextEditingController receiverInfoMobileController =
      TextEditingController();
  final TextEditingController receiverInfoEmailController =
      TextEditingController();
  final TextEditingController receiverInfoAreaController =
      TextEditingController();

  final TextEditingController diffrentZipController = TextEditingController();
  final TextEditingController diffrentStateController = TextEditingController();
  final TextEditingController diffrentCityController = TextEditingController();
  final TextEditingController diffrentAddress1Controller =
      TextEditingController();
  final TextEditingController diffrentAddress2Controller =
      TextEditingController();
  final TextEditingController shipmentChargeController =
      TextEditingController();
  final TextEditingController insuranceChargeController =
      TextEditingController();
  final TextEditingController odaChargeController = TextEditingController();
  final TextEditingController holidayChargeController = TextEditingController();
  final TextEditingController headlingChargeController =
      TextEditingController();
  final TextEditingController totalChargeController = TextEditingController();
  final TextEditingController gstChargeController = TextEditingController();
  final TextEditingController docketNoController = TextEditingController();

  var handlingChargeController = TextEditingController();
  List<Widget> shipmentList = [
    AddShipmentView(),
    AddAddressView(),
    AddDifferentAddressView(),
    AddPaymentInfoView()
  ];

  final isLoadingCustomers = false.obs;
  final isLoadingReceiverCustomer = false.obs;
  final isLoadingCate = false.obs;
  final isLoadingCommodity = false.obs;
  final isServiceType = false.obs;
  final isLoadingPincode = false.obs;
  final isLoadingDiffPincode = false.obs;
  final isLoadingArea = false.obs;
  final isLoadingDiffArea = false.obs;

  var selectedCustomer = Rxn<String>();
  var selectedExitingCustomer = Rxn<String>();
  var selectedReceiverCustomer = Rxn<String>();
  var selectedCategory = Rxn<String>();

  var selectedCommodity = Rxn<String>();

  var selectedServiceType = Rxn<String>();

  var selectedArea = Rxn<String>();
  var selectedDiffrentArea = Rxn<String>();

  var selectedPaymentModeId = Rxn<String>();
  var selectedSubPaymentId = Rxn<String>();

  RxString insuranceType = 'YES'.obs;
  RxString diffrentAddressType = 'NO'.obs;
  RxString addressType = '2'.obs;
  RxString receviverAddressType = '2'.obs;
  var currentPage = 0.obs;
  RxInt totalPage = 5.obs;
  final errorMessage = RxString('');

  var gstAmount = 0.0.obs;
  var grandTotal = 0.0.obs;
  var totalAmount = 0.0.obs;

  void calculateGST() {
    final shipment = double.tryParse(shipmentChargeController.text) ?? 0.0;
    final insurance = double.tryParse(insuranceChargeController.text) ?? 0.0;
    final oda = double.tryParse(odaChargeController.text) ?? 0.0;

    final handling = double.tryParse(handlingChargeController.text) ?? 0.0;

    final totalCharges = shipment + insurance + oda + handling;

    const gstRate = 18.0; // 18% GST
    final gst = (totalCharges * gstRate) / 100;
    final grandTotalAmount = totalCharges + gst;

    // Update the controllers:
    totalChargeController.text = totalCharges.toStringAsFixed(2);
    gstChargeController.text = grandTotalAmount.toStringAsFixed(2);

    // Update observables (optional if you want to show somewhere)
    gstAmount.value = gst;
    grandTotal.value = grandTotalAmount;
  }

  Future<void> fetchCustomers([String nextID = '']) async {
    try {
      isLoadingCustomers(true);
      isLoadingReceiverCustomer(true);
      final data = await addShipmentRepo.customerListRepo('', nextID);
      customerList.value = data ?? [];
    } catch (e) {
      customerList.value = [];
      Utils().logError(
        'Customer fetch failed $e',
      );
    } finally {
      isLoadingCustomers(false);
      isLoadingReceiverCustomer(false);
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

  Future<void> calculateGrossWeight({
    required String netWeight,
    required String grossWeight,
    required String status,
    required String productID,
  }) async {
    try {
      final result = await addShipmentRepo.grossCalculationRepo(
        netWeight,
        grossWeight,
        status,
        productID,
      );

      if (result == false) {
        // Handle gross weight validation failed
        log('Gross weight should be greater than Net weight!');
      } else if (result == true) {
        // Success case, continue
      } else {
        // Null or unknown error
        log('Gross weight should be greater than Net weight!');
      }
    } catch (e) {
      log('Gross weight should be greater than Net weight!');
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
    if (currentPage.value < 4) {
      currentPage++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      submitFormShipment();
    }
  }

  void submitFormShipment() async {
    // Collect all form data (0 to 4 steps)
    for (int i = 0; i <= 4; i++) {
      shipmentData = collectFormData(i);
    }

    final payload = shipmentData.toJson();
    Utils().log("Final Shipment Data: $payload");
    await sendShipmentToAPI(shipmentData);
    // Optional dialog to preview
    // Get.defaultDialog(
    //   title: "Shipment Preview",
    //   content: SingleChildScrollView(
    //     child: Text(payload.toString()),
    //   ),
    //   textConfirm: "Submit",
    //   onConfirm: () async {
    //     Get.back();
    //     await sendShipmentToAPI(shipmentData);
    //   },
    // );
  }

  Future<void> sendShipmentToAPI(ShipmentRequestModel data) async {
    try {
      final isSuccess = await addShipmentRepo.addShipment(
        data.customerID,
        data.selectedCate,
        data.selectedCommdity,
        data.newWeight,
        data.grossWeight,
        data.paymentMode,
        data.serviceType,
        data.policyNo,
        data.expireDate,
        data.insuranceAmt,
        data.insurance,
        "", // addInsurance if available
        "", // shipmentStatus
        "", // caculationStatus
        "", // addedBy
        "", // addedType
        "", // alertShipment
        "", // shipmentInvoice
        "", // isAmtEditedByUser
        data.docketNo, // shipmentID
        data.sendInfoName,
        data.sendInfoCompanyName,
        "", // senderCountry
        data.sendInfoState,
        data.sendInfoCity,
        data.sendInfoAera,
        data.sendInfoZip,
        data.sendInfoAddress1,
        data.sendInfoAddress2,
        data.sendInfoMobile,
        data.sendInfoEmail,
        "", // senderSaveAddress
        "", // senderisNewAdresss
        data.sendInfoGstNo,
        "", // senderCustID
        data.receiverInfoName,
        data.remark,
        "", // billTo
        data.noOfParcel,
        data.receiverInfoCompanyName,
        "", // receiverCountry
        data.receiverInfoState,
        data.receiverInfoCity,
        data.receiverInfoAera,
        data.receiverInfoZip,
        data.receiverInfoAddress1,
        data.receiverInfoAddress2,
        data.receiverInfoMobile,
        data.receiverInfoEmail,
        "", // receiverSaveAddress
        "", // receiverisNewAdresss
        data.receiverInfoGstNo,
        "", // receiverCustID
        "1", // isDiffAdd (or logic to check if different address is used)
        "", // diffReceiverCountry
        data.differentInfoState,
        data.differentInfoCity,
        data.differentInfoAera,
        data.differentInfoZip,
        data.differentInfoAddress1,
        data.differentInfoAddress2,
        data.shipmentCharges,
        data.insuranceCharge,
        "", // invoiceCharges
        data.handlingCharge,
        data.gst,
        data.totalCharge,
        "", // grandeTotal
        data.docketNo, // docketNo
        data.shipmentSelectedDate,
      );

      if (isSuccess == true) {
        Get.snackbar(
          'success',
          "Shipment added successfully!",
          colorText: themes.whiteColor,
          backgroundColor: themes.darkCyanBlue,
        );
      } else {
        Get.snackbar(
          'failed',
          "Shipment add failed!",
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
        );
      }
    } catch (e) {
      Utils().logError("Error sending shipment: $e");
      Get.snackbar('error', "Shipment error!");
    }
  }

  ShipmentRequestModel collectFormData(int step) {
    switch (step) {
      case 0:
        return shipmentData.copyWith(
          shipmentSelectedDate: selectedDate.value.toString().split("T")[0],
          customerID: selectedCustomer.value,
          selectedCate: selectedCategory.value,
          selectedCommdity: selectedCommodity.value,
          newWeight: netWeightController.text,
          grossWeight: grossWeightController.text,
          paymentMode: selectedPaymentModeId.value,
          noOfParcel: noOfParcelController.text,
          serviceType: selectedServiceType.value,
          insurance: insuranceType.value,
          policyNo: policyNoController.text,
          expireDate: expireDate.toString().split("T")[0],
          insuranceAmt: insuranceValueController.text,
          invoiceNo: invoiceNoController.text,
          remark: remarkController.text,
        );
      case 1:
        return shipmentData.copyWith(
          sendInfoName: senderInfoNameController.text,
          sendInfoCompanyName: senderInfoCompanyNameController.text,
          sendInfoZip: senderInfoZipController.text,
          sendInfoState: pincodeDetailsData.value?.stateId,
          sendInfoCity: pincodeDetailsData.value?.cityId,
          sendInfoAera: selectedArea.value,
          sendInfoGstNo: senderInfoGstNoController.text,
          sendInfoAddress1: senderInfoAddress1Controller.text,
          sendInfoAddress2: senderInfoAddress2Controller.text,
          sendInfoMobile: senderInfoMobileController.text,
          sendInfoEmail: senderInfoExitingEmailController.text,
        );
      case 2:
        return shipmentData.copyWith(
          receiverInfoName: senderInfoNameController.text,
          receiverInfoCompanyName: senderInfoCompanyNameController.text,
          receiverInfoZip: receiverInfoZipController.text,
          receiverInfoState: receiverInfoStateController.text,
          receiverInfoCity: receiverInfoCityController.text,
          receiverInfoAera: selectedArea.value,
          receiverInfoGstNo: receiverInfoGstNoController.text,
          receiverInfoAddress1: receiverInfoAddress1Controller.text,
          receiverInfoAddress2: receiverInfoAddress2Controller.text,
          receiverInfoMobile: receiverInfoMobileController.text,
          receiverInfoEmail: receiverInfoEmailController.text,
        );
      case 3:
        return shipmentData.copyWith(
          differentInfoZip: diffrentZipController.text,
          differentInfoState: pincodeDataDiff.value?.stateId,
          differentInfoCity: pincodeDataDiff.value?.cityId,
          differentInfoAera: selectedDiffrentArea.value,
          differentInfoAddress1: diffrentAddress1Controller.text,
          differentInfoAddress2: diffrentAddress2Controller.text,
        );
      case 4:
        return shipmentData.copyWith(
          shipmentCharges: shipmentChargeController.text,
          insuranceCharge: insuranceChargeController.text,
          odaCharge: odaChargeController.text,
          holidayCharge: holidayChargeController.text,
          handlingCharge: headlingChargeController.text,
          totalCharge: totalChargeController.text,
          gst: gstChargeController.text,
          docketNo: docketNoController.text,
          shipmentID: docketNoController.text,
        );
      default:
        return shipmentData;
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
    shipmentChargeController.dispose();
    insuranceChargeController.dispose();
    odaChargeController.dispose();
    holidayChargeController.dispose();
    handlingChargeController.dispose();
    totalChargeController.dispose();
    gstChargeController.dispose();
    super.onClose();
    pageController.dispose();
  }
}
