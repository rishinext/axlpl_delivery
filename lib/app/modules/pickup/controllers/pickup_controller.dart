import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/messnager_model.dart';
import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_endpoint.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

class PickupController extends GetxController {
  //TODO: Implement PickupController
  final Dio dio = Dio();
  ApiClient apiClient = ApiClient();
  final pickupRepo = PickupRepo();
  final shipmentRepo = ShipnowRepo();

  final shipmentController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final otpController = TextEditingController();
  final TextEditingController chequeNumberController = TextEditingController();

  final Map<String, TextEditingController> amountControllers = {};
  final Map<String, TextEditingController> chequeControllers = {};
  final Map<String, TextEditingController> otpControllers = {};
  final Map<String, Rxn<PaymentMode>> selectedSubPaymentModes = {};

  TextEditingController getAmountController(String shipmentId) =>
      amountControllers.putIfAbsent(shipmentId, () => TextEditingController());

  TextEditingController getChequeController(String shipmentId) =>
      chequeControllers.putIfAbsent(shipmentId, () => TextEditingController());

  TextEditingController getOtpController(String shipmentId) =>
      otpControllers.putIfAbsent(shipmentId, () => TextEditingController());

  Rxn<PaymentMode> getSelectedSubPaymentMode(String shipmentId) =>
      selectedSubPaymentModes.putIfAbsent(shipmentId, () => Rxn<PaymentMode>());

  void setSelectedSubPaymentMode(String shipmentId, PaymentMode? mode) =>
      getSelectedSubPaymentMode(shipmentId).value = mode;

  var selectedPaymentModeId = Rxn<String>();

  final pickupList = <RunningPickUp>[].obs;
  final messangerList = <MessangerList>[].obs;

  var paymentModes = <PaymentMode>[].obs;
  var subPaymentModes = <PaymentMode>[].obs;

  var selectedPaymentMode = Rxn<PaymentMode>();
  var selectedSubPaymentMode = Rxn<PaymentMode>();
  var isLoadingPayment = false.obs;

  final RxList<RunningPickUp> filteredPickupList = <RunningPickUp>[].obs;

  var isPickupLoading = Status.initial.obs;
  var isUploadPickup = Status.initial.obs;
  var isMessangerLoading = Status.initial.obs;
  var isTrasferLoading = Status.initial.obs;
  var isTransferLoading = Status.initial.obs;
  var isTransferSuccess = false.obs;
  var isPaymentLoading = Status.initial.obs;
  var isOtpLoading = Status.initial.obs;

  RxInt isSelected = 0.obs;
  var selectedPay = Rxn<String>();

  var selectedMessenger = ''.obs;
  final currentUserId = ''.obs;

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  void setSelectedPaymentMode(PaymentMode? mode) async {
    selectedPaymentMode.value = mode;
    selectedSubPaymentMode.value = null; // reset sub mode selection
    // optional call
  }

  void initializeUserId() async {
    final userData = await LocalStorage().getUserLocalData();
    currentUserId.value = userData?.messangerdetail?.id.toString() ?? '-1';
  }

  Future<void> getMessangerData() async {
    isMessangerLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getMessangerRepo('0');
      if (success != null) {
        messangerList.value = success;

        isMessangerLoading.value = Status.success;
      } else {
        Utils().logInfo('No messanger Data Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      messangerList.value = [];
    }
  }

  Future<void> getPickupData() async {
    isPickupLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllPickupRepo('0');
      if (success != null) {
        pickupList.value = success;
        filteredPickupList.value = success;

        if (success.isNotEmpty) {
          amountController.text = success.first.totalCharges.toString();
        } else {
          amountController.text;
        }
        isPickupLoading.value = Status.success;
      } else {
        Utils().logInfo('No pickup Record Found!');
        amountController.text;
        isPickupLoading.value = Status.error;
      }
    } catch (e) {
      Utils().logError(e.toString());
      pickupList.value = [];
      filteredPickupList.value = [];
      amountController.text; // Default on error
      isPickupLoading.value = Status.error;
    }
  }

  // Future<void> getPaymentModeData() async {
  //   try {
  //     isPaymentLoading.value = Status.loading;

  //     final result = await pickupRepo.getPaymentMode();

  //     if (result != null) {
  //       paymentModes.value = result;
  //       log("list log ${paymentModes.toString()}");

  //       for (var mode in result) {
  //         log("✅ Payment Mode: id=${mode.id}, name=${mode.name}");
  //       }

  //       isPaymentLoading.value = Status.success;
  //     } else {
  //       paymentModes.clear();
  //       Utils().log('⚠️ Payment modes list is empty');
  //       isPaymentLoading.value = Status.error;
  //     }
  //   } catch (e) {
  //     paymentModes.clear();
  //     isPaymentLoading.value = Status.error;
  //     Utils().logError("❌ Error fetching payment mode: $e");
  //   }
  // }
  Future<void> fetchPaymentModes() async {
    isLoadingPayment.value = true;
    try {
      final response = await dio.get(apiClient.baseUrl + getPaymentModePoint);

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = PaymentModesResponse.fromJson(response.data);
        paymentModes.value = data.data.paymentModes;
        subPaymentModes.value = data.data.subPaymentModes;
      } else {
        Get.snackbar('Error', 'Failed to fetch payment modes');
      }
    } catch (e) {
      Get.snackbar('Error', 'Dio Error: $e');
    } finally {
      isLoadingPayment.value = false;
    }
  }

  Future<void> uploadPickup(
    final shipmentID,
    final shipmentStatus,
    final date,
    final cashAmount,
    final paymentMode,
    final subPaymentMode,
    final otp, {
    String? chequeNumber,
  }) async {
    isUploadPickup.value = Status.loading;
    try {
      final success = await pickupRepo.uploadPickupRepo(
        shipmentID,
        shipmentStatus,
        date,
        cashAmount,
        paymentMode,
        subPaymentMode,
        otp,
        chequeNumber: chequeNumber,
      );

      if (success == true) {
        Get.snackbar(
          'Success',
          'Upload pickup successful!',
          colorText: themes.whiteColor,
          backgroundColor: themes.darkCyanBlue,
        );
        isUploadPickup.value = Status.success;
        getPickupData();
        final historyController = Get.find<HistoryController>();
        historyController.getPickupHistory();
        otpController.clear();
        // Delay navigation to allow snackbar to show
        Future.delayed(const Duration(seconds: 1), () {
          Get.back(); // Navigate back on success
        });
      } else {
        Get.snackbar(
          'Failed',
          'Upload pickup failed. Please try again.',
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
        );
        isUploadPickup.value = Status.error;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        colorText: themes.whiteColor,
        backgroundColor: themes.redColor,
      );
      isUploadPickup.value = Status.error;
    }
  }

  Future getOtp(final shipmentID) async {
    isOtpLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getOtpRepo(shipmentID);
      if (success == true) {
        Get.snackbar('OTP', 'OTP sended successfully!',
            colorText: themes.whiteColor, backgroundColor: themes.darkCyanBlue);
        isOtpLoading.value = Status.success;
      } else {
        Get.snackbar('Error', 'Failed to send OTP',
            colorText: themes.whiteColor, backgroundColor: themes.redColor);
        isOtpLoading.value = Status.error;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP: $e',
          backgroundColor: themes.redColor, colorText: themes.whiteColor);
      isOtpLoading.value = Status.error;
    }
  }

  Future<void> transferShipment(
    final shipmentID,
    final transferTo,
  ) async {
    isTransferLoading.value = Status.loading;
    try {
      final success = await shipmentRepo.trasferShipmentRepo(
        shipmentID,
        transferTo,
        'pickup',
      );
      if (success) {
        Get.snackbar('Success', 'Shipment Transfer Success!',
            colorText: themes.whiteColor, backgroundColor: themes.darkCyanBlue);
        isTransferLoading.value = Status.success;
        isTransferSuccess.value = true;
        getPickupData();
      } else {
        Get.snackbar('Failed', 'Shipment Transfer Failed!',
            colorText: themes.whiteColor, backgroundColor: themes.redColor);
        isTransferLoading.value = Status.error;
        isTransferSuccess.value = false;
      }
    } catch (e) {
      Get.snackbar('Failed', 'Shipment Transfer Failed!',
          colorText: themes.whiteColor, backgroundColor: themes.redColor);
      isTransferLoading.value = Status.error;
      isTransferSuccess.value = false;
    }
  }

  void filterByQuery(String query) {
    if (query.isEmpty) {
      filteredPickupList.value = pickupList;
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredPickupList.value = pickupList.where((pickup) {
        final pincode = (pickup.pincode ?? '').toLowerCase();
        final name = (pickup.name ?? '').toLowerCase();
        final address = (pickup.address1 ?? '').toLowerCase();
        final city = (pickup.cityName ?? '').toLowerCase();
        final shipmentID = (pickup.shipmentId ?? '').toLowerCase();

        return pincode.contains(lowerQuery) ||
            name.contains(lowerQuery) ||
            address.contains(lowerQuery) ||
            city.contains(lowerQuery) ||
            shipmentID.contains(lowerQuery);
      }).toList();
    }
  }

  Future<void> openMapWithAddress(
      String companyName, String address, String pincode) async {
    final fullQuery = '$companyName, $address, $pincode';
    final encodedQuery = Uri.encodeComponent(fullQuery);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedQuery';
    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // getPickupData();
    // getPaymentModeData();
    getMessangerData();
    initializeUserId();
    super.onInit();
  }
}
