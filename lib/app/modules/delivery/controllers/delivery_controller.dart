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

  final Map<String, Rxn<PaymentMode>> selectedSubPaymentModes = {};

  Rxn<PaymentMode> getSelectedSubPaymentMode(String shipmentId) {
    return selectedSubPaymentModes.putIfAbsent(
        shipmentId, () => Rxn<PaymentMode>());
  }

  void setSelectedSubPaymentMode(String shipmentId, PaymentMode? mode) {
    getSelectedSubPaymentMode(shipmentId).value = mode;
  }

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController chequeNumberController = TextEditingController();

  final Map<String, TextEditingController> amountControllers = {};
  final Map<String, TextEditingController> chequeControllers = {};
  final Map<String, TextEditingController> accountControllers = {};
  final Map<String, TextEditingController> onlineControllers = {};
  final Map<String, TextEditingController> otpControllers = {};

  TextEditingController getAmountController(String shipmentId) {
    return amountControllers.putIfAbsent(
        shipmentId, () => TextEditingController());
  }

  TextEditingController getChequeController(String shipmentId) {
    return chequeControllers.putIfAbsent(
        shipmentId, () => TextEditingController());
  }

  TextEditingController getAccountController(String shipmentId) {
    return accountControllers.putIfAbsent(
        shipmentId, () => TextEditingController());
  }

  TextEditingController getOnlineController(String shipmentId) {
    return onlineControllers.putIfAbsent(
        shipmentId, () => TextEditingController());
  }

  TextEditingController getOtpController(String shipmentId) {
    return otpControllers.putIfAbsent(
        shipmentId, () => TextEditingController());
  }

  TextEditingController amountController = TextEditingController();
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

        // Initialize amount controllers per shipment with totalCharges
        for (var delivery in success) {
          final controller =
              getAmountController(delivery.shipmentId.toString());
          controller.text = delivery.totalCharges.toString();
        }
      } else {
        Utils().logInfo('No delivery Record Found!');
        isDeliveryLoading.value = Status.error;
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
      Utils().logInfo('Uploading delivery with data:');
      Utils().logInfo({
        'shipmentID': shipmentID,
        'shipmentStatus': shipmentStatus,
        'id': id,
        'date': date,
        'amtPaid': amtPaid,
        'cashAmount': cashAmount,
        'paymentMode': paymentMode,
        'subPaymentMode': subPaymentMode,
        'deliveryOtp': deliveryOtp,
        'chequeNumber': chequeNumber,
      });
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
          'Delivery uploaded successfully',
          backgroundColor: themes.darkCyanBlue,
          colorText: themes.whiteColor,
        );
        isUploadDelivery.value = Status.success;
        getDeliveryData();
        final historyController = Get.find<HistoryController>();
        historyController.getDeliveryHistory();
        otpController.clear();
        Future.delayed(const Duration(seconds: 1), () {
          Get.back(); // Navigate back on success
        });
      } else {
        Get.snackbar(
          'Failed',
          'Delivery uploaded failed',
          backgroundColor: themes.redColor,
          colorText: themes.whiteColor,
        );
        isUploadDelivery.value = Status.error;
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        backgroundColor: themes.redColor,
        colorText: themes.whiteColor,
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
