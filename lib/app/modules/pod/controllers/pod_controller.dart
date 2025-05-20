import 'dart:io';

import 'package:axlpl_delivery/app/data/models/shipment_record_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pod_repo.dart';
// ignore: unused_import
import 'package:axlpl_delivery/app/data/networking/repostiory/profile_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PodController extends GetxController {
  //TODO: Implement PodController
  final _repo = PodRepo();
  TextEditingController shipmentIdController = TextEditingController();

  final shipmentRecordList = <ShipmentRecordList>[].obs;

  var imageFile = Rx<File?>(null);

  final paymentModes = [
    {'id': '1', 'name': 'Prepaid'},
    {'id': '2', 'name': 'To Pay'},
    {'id': '3', 'name': 'Paid Cash'},
    {'id': '4', 'name': 'To Pay Cash'},
    {'id': '5', 'name': 'Account (contract)'},
  ].obs;
  final paymentTypes = [
    {'id': '1', 'name': 'Account '},
    {'id': '2', 'name': 'Cash'},
    {'id': '3', 'name': 'Cheque'},
    {'id': '4', 'name': 'Online /add shipment'},
  ].obs;

  final isPod = Status.initial.obs;
  final isShipmentRecord = Status.initial.obs;

  final message = ''.obs;

  var selectedPaymentModeId = Rxn<String>();
  var selectedPaymentTypeId = Rxn<String>();

  Future<void> uploadPod({
    required String shipmentStatus,
    required String shipmentOtp,
    required File file,
  }) async {
    try {
      isPod.value = Status.loading;
      message.value = '';

      final result = await _repo.profilePhotoUploadRepo(
        shipmentIdController.text,
        shipmentStatus,
        shipmentOtp,
        file,
      );

      if (result) {
        isPod.value = Status.success;
        message.value = _repo.apiMessage ?? 'Upload successful';
        shipmentIdController.clear();

        Get.snackbar("Success", message.value,
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        isPod.value = Status.error;
        message.value = _repo.apiMessage ?? 'Upload failed';
        Get.snackbar("Error", message.value,
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      isPod.value = Status.error;
      message.value = 'Unexpected error: $e';
      Get.snackbar(
        "Error",
        message.value,
        backgroundColor: themes.redColor,
      );
    }
  }

  Future<void> getShipmentRecord(final shipmentID) async {
    isShipmentRecord.value = Status.loading;
    try {
      final success = await _repo.getShipmentRecordRepo(shipmentID);
      if (success.isNotEmpty) {
        shipmentRecordList.value = success;
        isShipmentRecord.value = Status.success;
      } else {
        Utils().logInfo('No Shipment Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      shipmentRecordList.value = [];
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shipmentIdController.dispose();
  }
}
