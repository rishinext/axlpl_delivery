import 'dart:developer';
import 'dart:math';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
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
  // ShipmentRequestModel shipmentData = ShipmentRequestModel();

  final customerList = <CustomersList>[].obs;
  final categoryList = <CategoryList>[].obs;
  final commodityList = <CommodityList>[].obs;
  final serviceTypeList = <ServiceTypeList>[].obs;
  final areaList = <AreaList>[].obs;
  final areaListDiff = <AreaList>[].obs;
  var pincodeDetailsData = Rxn<GetPincodeDetailsModel>(null);
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
      final data = await addShipmentRepo.customerListRepo('version', nextID);
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
        print('Gross weight should be greater than Net weight!');
      } else if (result == true) {
        // Success case, continue
      } else {
        // Null or unknown error
        print('Gross weight should be greater than Net weight!');
      }
    } catch (e) {
      print('Gross weight should be greater than Net weight!');
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
    try {
      final shipment = ShipmentModel(
        shipmentId: '',
        customerId: selectedCustomer.value ?? '0',
        categoryId: selectedCategory.value ?? '0',
        productId: selectedCommodity.value ?? '0',
        netWeight: netWeightController.text,
        grossWeight: grossWeightController.text,
        paymentMode: selectedPaymentModeId.value ?? "0",
        serviceId: selectedServiceType.value,
        invoiceValue: invoiceNoController.text,
        axlplInsurance: insuranceType.value,
        policyNo: policyNoController.text,
        expDate: expireDate.toString(),
        insuranceValue: insuranceValueController.text,
        shipmentStatus: '',
        calculationStatus: 'custom',
        addedBy: 1,
        addedByType: 'System',
        preAlertShipment: 0,
        shipmentInvoiceNo: invoiceNoController.text,
        isAmtEditedByUser: 0,
        remark: remarkController.text,
        billTo: 2,
        numberOfParcel: noOfParcelController.text,
        additionalAxlplInsurance: 0.00,
        shipmentCharges: shipmentChargeController.text,
        insuranceCharges: insuranceChargeController.text,
        invoiceCharges: insuranceValueController.text,
        handlingCharges: handlingChargeController.text,
        tax: gstChargeController.text,
        totalCharges: totalChargeController.text,
        grandTotal: grandeChargeController.text,
        docketNo: docketNoController.text,
        shipmentDate: '',
        senderName: senderInfoNameController.text,
        senderCompanyName: senderInfoCompanyNameController.text,
        senderCountry: 1,
        senderState: senderInfoStateController.text,
        senderCity: senderInfoCityController.text,
        senderArea: senderInfoAreaController.text,
        senderPincode: senderInfoZipController.text,
        senderAddress1: senderInfoAddress1Controller.text,
        senderAddress2: senderInfoAddress2Controller.text,
        senderMobile: senderInfoMobileController.text,
        senderEmail: senderInfoEmailController.text,
        senderSaveAddress: 1,
        senderIsNewSenderAddress: addressType.value,
        senderGstNo: senderInfoGstNoController.text,
        senderCustomerId: selectedExitingCustomer.value,
        receiverName: receiverInfoNameController.text,
        receiverCompanyName: receiverInfoCompanyNameController.text,
        receiverCountry: 1,
        receiverState: receiverInfoStateController.text,
        receiverCity: receiverInfoCityController.text,
        receiverArea: receiverInfoAreaController.text,
        receiverPincode: receiverInfoZipController.text,
        receiverAddress1: receiverInfoAddress1Controller.text,
        receiverAddress2: receiverInfoAddress2Controller.text,
        receiverMobile: receiverInfoMobileController.text,
        receiverEmail: receiverInfoEmailController.text,
        receiverSaveAddress: 1,
        receiverIsNewReceiverAddress: receviverAddressType.value,
        receiverGstNo: receiverInfoGstNoController.text,
        receiverCustomerId: selectedReceiverCustomer.value,
        isDiffAdd: receviverAddressType.value,
        diffReceiverCountry: 0,
        diffReceiverState: diffrentStateController.text,
        diffReceiverCity: diffrentCityController.text,
        diffReceiverArea: diffrentAeraController.text,
        diffReceiverPincode: diffrentZipController.text,
        diffReceiverAddress1: diffrentAddress1Controller.text,
        diffReceiverAddress2: diffrentAddress2Controller.text,
      );

      final response =
          await addShipmentRepo.addShipmentRepo(shipmentModel: shipment);

      if (response == Status.success) {
        Get.snackbar('Success', 'Shipment added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add shipment');
      }
    } catch (e) {
      Get.snackbar('Error', 'Unexpected error occurred');
      print('Shipment submission error: $e');
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
