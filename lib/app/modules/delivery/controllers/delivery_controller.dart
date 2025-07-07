import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_endpoint.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/delivery_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryController extends GetxController {
  final pickupRepo = PickupRepo();
  final deliveryRepo = DeliveryRepo();
  final Dio dio = Dio();
  ApiClient apiClient = ApiClient();
  final historyController = Get.put(HistoryController());
  //TODO: Implement DeliveryController
  var isDeliveryLoading = Status.initial.obs;
  var isUploadDelivery = Status.initial.obs;
  final currentUserId = ''.obs;
  RxInt isSelected = 0.obs;

  final deliveryList = <RunningDelivery>[].obs;
  final RxList<RunningDelivery> filteredDeliveryList = <RunningDelivery>[].obs;

  var subPaymentModes = <PaymentMode>[].obs;
  var selectedSubPaymentMode = Rxn<PaymentMode>();
  void setSelectedSubPaymentMode(PaymentMode? mode) {
    selectedSubPaymentMode.value = mode;
  }

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController chequeNumberController = TextEditingController();

  final amountController = TextEditingController();
  var isLoadingPayment = false.obs;

  void initializeUserId() async {
    final userData = await LocalStorage().getUserLocalData();
    currentUserId.value = userData?.messangerdetail?.id.toString() ?? '-1';
  }

  Future<void> getDeliveryData() async {
    isDeliveryLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllDeliveryRepo('0');
      if (success != null) {
        deliveryList.value = success;
        filteredDeliveryList.value = success;
        isDeliveryLoading.value = Status.success;
      } else {
        Utils().logInfo('No delivery Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      deliveryList.value = [];
      filteredDeliveryList.value = [];
      isDeliveryLoading.value = Status.error;
    }
  }

  Future<void> uploadDelivery(
    shipmentID,
    shipmentStatus,
    id,
    date,
    amtPaid,
    cashAmount,
    paymentMode,
    subPaymentMode,
    deliveryOtp, {
    String? chequeNumber,
  }) async {
    isUploadDelivery.value = Status.loading;
    try {
      final success = await deliveryRepo.uploadDeliveryRepo(
        shipmentID,
        shipmentStatus,
        id,
        date,
        amtPaid,
        cashAmount,
        paymentMode,
        subPaymentMode,
        deliveryOtp,
        chequeNumber: chequeNumber,
      );

      if (success == true) {
        Get.snackbar(
          'Success',
          'Upload Delivery Successful!',
          colorText: themes.whiteColor,
          backgroundColor: themes.darkCyanBlue,
        );
        isUploadDelivery.value = Status.success;
        getDeliveryData();
        final historyController = Get.find<HistoryController>();
        historyController.getDeliveryHistory();
        otpController.clear();
        Get.back(); // Navigate back on success
      } else {
        Get.snackbar(
          'Failed',
          'Upload Delivery failed. Please try again.',
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
        );
        isUploadDelivery.value = Status.error;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        colorText: themes.whiteColor,
        backgroundColor: themes.redColor,
      );
      isUploadDelivery.value = Status.error;
    }
  }

  void filterByPincode(String query) {
    if (query.isEmpty) {
      filteredDeliveryList.value = deliveryList;
    } else {
      filteredDeliveryList.value = deliveryList
          .where((pickup) => (pickup.pincode ?? '').contains(query.trim()))
          .toList();
    }
  }

  Future<void> fetchPaymentModes() async {
    isLoadingPayment.value = true;
    try {
      final response = await dio.get(apiClient.baseUrl + getPaymentModePoint);

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = PaymentModesResponse.fromJson(response.data);

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

  @override
  void onInit() {
    // getDeliveryData();
    initializeUserId();
    // historyController.getDeliveryHistory('0');
    super.onInit();
  }
}
