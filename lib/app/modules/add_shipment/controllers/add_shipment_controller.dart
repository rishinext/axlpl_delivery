import 'dart:developer';
import 'dart:math';
import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:intl/intl.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_cal_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/add_shipment_repo.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_sender_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_different_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_payment_info_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddShipmentController extends GetxController {
  //TODO: Implement AddShipmentController

  final addShipmentRepo = AddShipmentRepo();
  // ShipmentRequestModel shipmentData = ShipmentRequestModel();

  String? userId;

  Future<void> _loadUserId() async {
    final userData = await LocalStorage().getUserLocalData();
    userId = userData?.messangerdetail?.id?.toString() ??
        userData?.customerdetail?.id.toString();
    Utils().log("User ID loaded: $userId");
  }

  final customerList = <CustomersList>[].obs;
  final customerReceiverList = <CustomersList>[].obs;
  final categoryList = <CategoryList>[].obs;
  final commodityList = <CommodityList>[].obs;
  final serviceTypeList = <ServiceTypeList>[].obs;
  final shipmentCalList = <PaymentInformation>[].obs;
  final senderAreaList = <AreaList>[].obs;
  final receiverAreaList = <AreaList>[].obs;
  final areaListDiff = <AreaList>[].obs;

  var pincodeDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var pincodeReceiverDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var areaDetailsData = Rxn<GetPincodeDetailsModel>(null);
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
  final TextEditingController invoiceValueController = TextEditingController();
  final TextEditingController insuranceValueController =
      TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final TextEditingController senderInfoNameController =
      TextEditingController();
  final TextEditingController senderInfoEmailController =
      TextEditingController();
  final TextEditingController senderInfoCompanyNameController =
      TextEditingController();
  final TextEditingController senderInfoZipController = TextEditingController();

  final TextEditingController senderInfoStateController =
      TextEditingController();
  final TextEditingController senderInfoAreaController =
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
  final TextEditingController receiverExistingNameController =
      TextEditingController();
  final TextEditingController receiverExistingCompanyNameController =
      TextEditingController();
  final TextEditingController receiverExistingZipController =
      TextEditingController();

  final TextEditingController receiverExistingStateController =
      TextEditingController();
  final TextEditingController receiverExistingCityController =
      TextEditingController();
  final TextEditingController receiverExistingGstNoController =
      TextEditingController();
  final TextEditingController receiverExistingAddress1Controller =
      TextEditingController();
  final TextEditingController receiverExistingAddress2Controller =
      TextEditingController();
  final TextEditingController receiverExistingMobileController =
      TextEditingController();
  final TextEditingController receiverExistingEmailController =
      TextEditingController();
  final TextEditingController receiverExistingAreaController =
      TextEditingController();

  final TextEditingController diffrentZipController = TextEditingController();
  final TextEditingController diffrentStateController = TextEditingController();
  final TextEditingController diffrentCityController = TextEditingController();
  final TextEditingController diffrentAeraController = TextEditingController();
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
  final TextEditingController grandeChargeController = TextEditingController();
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
  final isLoadingReceiverPincode = false.obs;
  final isLoadingDiffPincode = false.obs;
  final isLoadingSenderArea = false.obs;
  final isLoadingReceiverArea = false.obs;
  final isLoadingDiffArea = false.obs;
  var isShipmentCal = Status.initial.obs;

  var selectedCustomer = Rxn();
  var selectedExitingCustomer = Rxn();
  var selectedReceiverCustomer = Rxn();
  var selectedCategory = Rxn();

  var selectedCommodity = Rxn();

  var selectedServiceType = Rxn();

  var selectedReceiverArea = Rxn();
  var selectedSenderArea = Rxn();
  var selectedDiffrentArea = Rxn();

  var selectedPaymentModeId = Rxn();
  var selectedPaymentMode = Rxn<PaymentMode>();
  var selectedSubPaymentMode = Rxn<PaymentMode>();

  var selectedSenderStateId = 0.obs;
  var selectedSenderCityId = 0.obs;
  var selectedSenderAreaId = 0.obs;

  var selectedReceiverStateId = 0.obs;
  var selectedReceiverCityId = 0.obs;
  var selectedReceiverAreaId = 0.obs;

  var selectedExistingSenderStateId = 0.obs;
  var selectedExistingSenderCityId = 0.obs;
  var selectedExistingSenderAreaId = 0.obs;

  var selectedExistingReceiverStateId = 0.obs;
  var selectedExistingReceiverCityId = 0.obs;
  var selectedExistingReceiverAreaId = 0.obs;

  var selectedDiffStateId = 0.obs;
  var selectedDiffCityId = 0.obs;
  var selectedDiffAreaId = 0.obs;

  void setSelectedPaymentMode(PaymentMode? mode) async {
    selectedPaymentMode.value = mode;
    // selectedSubPaymentMode.value = null; // reset sub mode selection
    // optional call
  }

  void setSelectedSubPaymentMode(PaymentMode? mode) {
    selectedSubPaymentMode.value = mode;
  }

  var selectedSubPaymentId = Rxn();

  var insuranceType = 0.obs;
  var diffrentAddressType = 0.obs;
  var senderAddressType = 1.obs;
  var receviverAddressType = 1.obs;
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

      final data = await addShipmentRepo.customerListRepo('version', nextID);
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

  Future<void> fetchReciverCustomers([String nextID = '']) async {
    try {
      isLoadingReceiverCustomer(true);

      final data = await addShipmentRepo.customerListRepo('version', nextID);
      customerReceiverList.value = data ?? [];
    } catch (e) {
      customerReceiverList.value = [];
      Utils().logError(
        'Receiver Customer fetch failed $e',
      );
    } finally {
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
        pincodeReceiverDetailsData.value = response;
      } else {
        pincodeDetailsData.value = null; // clear invalid data
        pincodeReceiverDetailsData.value = null;
        errorMessage.value = 'Invalid pincode!';
      }
    } catch (e) {
      pincodeDetailsData.value = null;
      pincodeReceiverDetailsData.value = null;
      errorMessage.value = 'Pincode fetch failed!';
      Utils().logError(
        'Pincode Fetch Failed $e',
      );
    } finally {
      isLoadingPincode.value = false;
    }
  }

  Future<void> fetchPincodeDetailsReceiverInfo(String pincode) async {
    errorMessage.value = '';
    try {
      isLoadingReceiverPincode.value = true;

      final response = await addShipmentRepo.pincodeDetailsRepo(pincode);

      if (response != null &&
          response.stateName != null &&
          response.cityName != null) {
        pincodeReceiverDetailsData.value = response;
      } else {
        pincodeReceiverDetailsData.value = null;
        errorMessage.value = 'Invalid pincode!';
      }
    } catch (e) {
      pincodeReceiverDetailsData.value = null;
      errorMessage.value = 'Pincode fetch failed!';
      Utils().logError(
        'Pincode Fetch Failed $e',
      );
    } finally {
      isLoadingReceiverPincode.value = false;
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

  Future fetchSenderAreaByZip(String zip) async {
    if (zip.isEmpty) return;
    try {
      isLoadingSenderArea(true);
      senderAreaList.clear();
      final data = await addShipmentRepo.allAeraByZipRepo(zip);
      if (data == null || data.isEmpty) {
        Utils().logInfo('No Area found for sender zip $zip');
      } else {
        senderAreaList.value = data;
      }
    } catch (error) {
      senderAreaList.clear();
      Utils().logError('Error getting sender areas $error');
    } finally {
      isLoadingSenderArea(false);
    }
  }

  Future fetchReceiverAreaByZip(String zip) async {
    if (zip.isEmpty) return;
    try {
      isLoadingReceiverArea(true);
      receiverAreaList.clear();
      final data = await addShipmentRepo.allAeraByZipRepo(zip);
      if (data == null || data.isEmpty) {
        Utils().logInfo('No Area found for receiver zip $zip');
      } else {
        receiverAreaList.value = data;
      }
    } catch (error) {
      receiverAreaList.clear();
      Utils().logError('Error getting receiver areas $error');
    } finally {
      isLoadingReceiverArea(false);
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

  // Future<void> shipmentCal(
  //   final custID,
  //   final cateID,
  //   final commID,
  //   final netWeight,
  //   final grossWeight,
  //   final paymentMode,
  //   final invoiceValue,
  //   final insuranceByAxlpl,
  //   final policyNo,
  //   final numberOfParcel,
  //   final expDate,
  //   final policyValue,
  //   final senderZip,
  //   final receiverZip,
  // ) async {
  //   isShipmentCal.value = Status.loading;
  //   try {
  //     final data = await addShipmentRepo.shipmentCalculationRepo(
  //       custID,
  //       cateID,
  //       commID,
  //       netWeight,
  //       grossWeight,
  //       paymentMode,
  //       invoiceValue,
  //       insuranceByAxlpl,
  //       policyNo,
  //       numberOfParcel,
  //       expDate,
  //       policyValue,
  //       senderZip,
  //       receiverZip,
  //     );
  //     shipmentCalList.value = data ?? [];
  //     isShipmentCal.value = Status.success;
  //   } catch (e) {
  //     shipmentCalList.value = [];
  //     isShipmentCal.value = Status.error;
  //     Utils().logError(
  //       'shipmentCal fetch failed $e',
  //     );
  //   }
  // }
  Future<void> shipmentCal(
    final custID,
    final cateID,
    final commID,
    final netWeight,
    final grossWeight,
    final paymentMode,
    final invoiceValue,
    final insuranceByAxlpl,
    final policyNo,
    final numberOfParcel,
    final expDate,
    final policyValue,
    final senderZip,
    final receiverZip,
  ) async {
    isShipmentCal.value = Status.loading;
    try {
      final data = await addShipmentRepo.shipmentCalculationRepo(
        custID,
        cateID,
        commID,
        netWeight,
        grossWeight,
        paymentMode,
        invoiceValue ?? 0,
        insuranceByAxlpl,
        policyNo ?? 0,
        numberOfParcel,
        expDate,
        policyValue ?? 0,
        senderZip,
        receiverZip,
      );
      shipmentCalList.value = data ?? [];

      if (shipmentCalList.isNotEmpty) {
        final paymentInfo = shipmentCalList.first;

        shipmentChargeController.text = paymentInfo.shipmentCharges ?? '';
        insuranceChargeController.text = paymentInfo.insuranceCharges ?? '';
        headlingChargeController.text = paymentInfo.handlingCharges ?? '';
        gstChargeController.text = paymentInfo.tax ?? '';

        totalChargeController.text = paymentInfo.totalCharges ?? '';
        grandeChargeController.text = paymentInfo.grandTotal ?? '';
        //  odaChargeController.text = paymentInfo.additionalAxlplInsurance ?? 0;
      }

      isShipmentCal.value = Status.success;
    } catch (e) {
      shipmentCalList.value = [];
      isShipmentCal.value = Status.error;
      Utils().logError('shipmentCal fetch failed $e');
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
    int current = currentPage.value;

    final isValid = formKeys[current].currentState?.validate() ?? false;
    if (!isValid) return;

    if (current == 4) {
      submitShipment();
    } else {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> submitShipment() async {
    final userData = await LocalStorage().getUserLocalData();
    final userID = userData?.messangerdetail?.id?.toString() ??
        userData?.customerdetail?.id.toString();
    try {
      final shipment = ShipmentModel(
        shipmentId: '',
        customerId: int.tryParse(selectedCustomer.value ?? '') ??
            int.tryParse(userID.toString()),
        categoryId: int.tryParse(selectedCategory.value) ?? 0,
        productId: int.tryParse(selectedCommodity.value) ?? 0,
        netWeight: int.tryParse(netWeightController.text) ?? 0,
        grossWeight: int.tryParse(grossWeightController.text) ?? 0,
        paymentMode: selectedPaymentMode.value?.id.toString() ??
            'prepaid', // or use expected string id
        serviceId: int.tryParse(selectedServiceType.value) ?? 0,
        invoiceValue: int.tryParse(invoiceNoController.text) ?? 0,
        axlplInsurance: insuranceType.value,
        policyNo: insuranceType.value == 0 ? 0 : policyNoController.text,
        expDate: insuranceType.value == 0
            ? ''
            : DateFormat('yyyy-MM-dd').format(expireDate.value),
        insuranceValue: insuranceType.value == 0
            ? 0
            : double.tryParse(insuranceValueController.text) ?? 0.0,
        shipmentStatus: '', // match Postman or your logic
        calculationStatus: 'custom',
        addedBy: 1,
        addedByType: 1, // as in Postman
        preAlertShipment: 0,
        shipmentInvoiceNo: int.tryParse(invoiceNoController.text) ?? 0,
        isAmtEditedByUser: 0,
        remark: remarkController.text,
        billTo: 2,
        numberOfParcel: int.tryParse(noOfParcelController.text) ?? 0,
        additionalAxlplInsurance: 0.0,
        shipmentCharges: double.tryParse(shipmentChargeController.text) ?? 0.0,
        insuranceCharges:
            double.tryParse(insuranceChargeController.text) ?? 0.0,
        invoiceCharges: double.tryParse(insuranceValueController.text) ?? 0.0,
        handlingCharges: double.tryParse(handlingChargeController.text) ?? 0.0,
        tax: double.tryParse(gstChargeController.text) ?? 0.0,
        totalCharges: double.tryParse(totalChargeController.text) ?? 0.0,
        grandTotal: double.tryParse(grandeChargeController.text) ?? 0.0,
        docketNo: docketNoController.text,
        shipmentDate: DateFormat('yyyy-MM-dd').format(selectedDate.value),

        senderName: senderAddressType.value == 0
            ? senderInfoNameController.text
            : existingSenderInfoNameController.text,
        senderCompanyName: senderAddressType.value == 0
            ? senderInfoCompanyNameController.text
            : existingSenderInfoCompanyNameController.text,
        senderCountry: 1,
        senderState: senderAddressType.value == 0
            ? selectedSenderStateId.value
            : selectedExistingSenderStateId.value,
        senderCity: senderAddressType.value == 0
            ? selectedSenderCityId.value
            : selectedExistingSenderCityId.value,
        senderArea: senderAddressType.value == 0
            ? selectedSenderAreaId.value
            : selectedExistingSenderAreaId.value,
        senderPincode: senderAddressType.value == 0
            ? int.tryParse(senderInfoZipController.text)
            : existingSenderInfoZipController.text,
        senderAddress1: senderAddressType.value == 0
            ? senderInfoAddress1Controller.text
            : existingSenderInfoAddress1Controller.text,
        senderAddress2: senderAddressType.value == 0
            ? senderInfoAddress2Controller.text
            : existingSenderInfoAddress2Controller.text,
        senderMobile: senderAddressType.value == 0
            ? int.tryParse(senderInfoMobileController.text)
            : int.tryParse(existingSenderInfoMobileController.text),
        senderEmail: senderAddressType.value == 0
            ? senderInfoEmailController.text
            : existingSenderInfoEmailController.text,
        senderSaveAddress: 0,
        senderIsNewSenderAddress: senderAddressType.value,
        senderGstNo: senderAddressType.value == 0
            ? senderInfoGstNoController.text
            : existingSenderInfoGstNoController.text,
        senderCustomerId: int.tryParse(selectedCustomer.value ?? '') ??
            int.tryParse(userID.toString()),
        receiverName: receviverAddressType.value == 0
            ? receiverInfoCompanyNameController.text
            : receiverExistingNameController.text,
        receiverCompanyName: receviverAddressType.value == 0
            ? receiverInfoCompanyNameController.text
            : receiverExistingCompanyNameController.text,
        receiverCountry: 1,
        receiverState: receviverAddressType.value == 0
            ? selectedReceiverStateId.value
            : selectedExistingReceiverStateId.value,

        receiverCity: receviverAddressType.value == 0
            ? selectedReceiverCityId.value
            : selectedExistingReceiverCityId.value,
        receiverArea: receviverAddressType.value == 0
            ? selectedReceiverAreaId.value
            : selectedExistingReceiverAreaId.value,
        receiverPincode: receviverAddressType.value == 0
            ? int.tryParse(receiverInfoZipController.text)
            : int.tryParse(receiverExistingZipController.text),
        receiverAddress1: receviverAddressType.value == 0
            ? receiverInfoAddress1Controller.text
            : receiverExistingAddress1Controller.text,
        receiverAddress2: receviverAddressType.value == 0
            ? receiverInfoAddress2Controller.text
            : receiverExistingAddress2Controller.text,
        receiverMobile: receviverAddressType.value == 0
            ? int.tryParse(receiverInfoMobileController.text)
            : int.tryParse(receiverExistingMobileController.text),
        receiverEmail: receviverAddressType.value == 0
            ? receiverInfoEmailController.text
            : receiverExistingEmailController.text,
        receiverSaveAddress: 0,
        receiverIsNewReceiverAddress: receviverAddressType.value,
        receiverGstNo: receviverAddressType.value == 0
            ? receiverInfoGstNoController.text
            : receiverExistingGstNoController.text,
        receiverCustomerId: selectedReceiverCustomer.value ?? userID,
        isDiffAdd: 0,
        diffReceiverCountry: diffrentAddressType.value,
        diffReceiverState: selectedDiffStateId.value,
        diffReceiverCity: selectedDiffCityId.value,
        diffReceiverArea: selectedDiffAreaId.value,
        diffReceiverPincode: int.tryParse(diffrentZipController.text) ?? 0,
        diffReceiverAddress1: diffrentAddress1Controller.text,
        diffReceiverAddress2: diffrentAddress2Controller.text,
      );

      final response =
          await addShipmentRepo.addShipmentRepo(shipmentModel: shipment);

      if (response == true) {
        Get.snackbar(
          'Success',
          'Shipment added successfully',
          backgroundColor: themes.darkCyanBlue,
          colorText: themes.whiteColor,
        );
      } else {
        Get.snackbar('Error', 'Failed to add shipment');
      }
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error occurred');
      Utils().logError('Shipment submission error: $e');
    }
  }
  // void testAddShipment() async {
  //   final shipmentDetails = ShipmentDetails(
  //     shipmentId: 12312345,
  //     addedByType: 'System',
  //     alertShipment: 0,
  //     isAmtEditedByUser: 0,
  //     // shipmentStatus: 'In Progress',
  //     custId: 123, // <-- set actual customer id
  //     addedBy: 0,
  //     parcelDetail: '1'.trim(),
  //     commodityID: 456, // <-- product id
  //     categoryId: 789,
  //     netWeight: 10.0,
  //     grossWeight: 12.0,
  //     paymentMode: 'prepaid',
  //     serviceId: 1,
  //     invoiceValue: 1000.0,
  //     axlplInsurance: 0,
  //     policyNo: 'POL123',
  //     expDate: '2025-12-31',
  //     insuranceValue: 500.0,
  //     invoiceNumber: 1,
  //     remark: 'fragile',
  //     billTo: 'billtoName',
  //     numberOfParcel: 1,
  //     additionalAxlplInsurance: 0.0,
  //     shipmentCharges: 100.0,
  //     insuranceCharges: 50.0,
  //     invoiceCharges: 0.0,
  //     handlingCharges: 10.0,
  //     tax: 18.0,
  //     totalCharges: 178.0,
  //     userId: 'user123',
  //     customerId: 3306,
  //     senderId: 123,
  //     gst: 'GST123',
  //     grandTotal: 178.0,
  //   );

  //   final sender = SenderData(
  //     senderSaveAddress: 1,
  //     senderIsNewSenderAddress: 1,
  //     senderName: 'John Doe',
  //     senderCustID: 1,
  //     companyName: 'Sender Co',
  //     mobile: '1234567890',
  //     senderEmail: 'a@mail.com',
  //     address1: '123 Street',
  //     address2: 'Suite 1',
  //     state: 4,
  //     city: 817,
  //     area: 63862,
  //     pincode: '400002',
  //     senderCountry: 1,
  //     senderGst: '27AACPJ9801C1Z1',
  //   );

  //   final receiver = ReceiverData(
  //     receiverSaveAddress: 1,
  //     receiverNewAddress: 1,
  //     receiverName: 'Jane Doe',
  //     companyName: 'Receiver Co',
  //     mobile: '0987654321',
  //     address1: '456 Avenue',
  //     address2: 'Apt 2',
  //     receiverCountry: 1,
  //     receiverEmail: 'rishi@version-next.com',
  //     receiverGst: 122222,
  //     receiverCustID: 624,
  //     state: 'StateA',
  //     city: 'CityB',
  //     area: 'AreaC',
  //     pincode: '654321',
  //   );

  //   final bool? response = await addShipmentRepo.addShipmentRepo(
  //     shipmentDetails: shipmentDetails,
  //     sender: sender,
  //     receiver: receiver,
  //     isDiffAdd: false,
  //     docketNo: 'DCKT001',
  //     shipmentDate: '2025-06-24',
  //     // alertShipment: false, // Add required bools here
  //     // isAmtEditedByUser: false,
  //     // shipmentStatus: 'pending',
  //     // calculationStatus: 'in_progress',
  //   );

  //   if (response == true) {
  //     print("✅ Shipment added successfully.");
  //   } else {
  //     print("❌ Shipment add failed.");
  //   }
  // }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  final pickupController = Get.find<PickupController>();
  @override
  void onInit() {
    // TODO: implement onInit
    _loadUserId();
    fetchCustomers('0');
    fetchReciverCustomers('0');
    categoryListData();
    fetchServiceType();
    paymentModes.refresh();
    pickupController.fetchPaymentModes();
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
    super.onInit();
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
