import 'dart:io';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pod_repo.dart';
// ignore: unused_import
import 'package:axlpl_delivery/app/data/networking/repostiory/profile_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PodController extends GetxController {
  //TODO: Implement PodController

  TextEditingController shipmentIdController = TextEditingController();

  var imageFile = Rx<File?>(null);

  final status = Status.initial.obs;
  final message = ''.obs;

  final _repo = PodRepo();

  Future<void> uploadPod({
    required String shipmentStatus,
    required String shipmentOtp,
    required File file,
  }) async {
    try {
      status.value = Status.loading;
      message.value = '';

      final result = await _repo.profilePhotoUploadRepo(
        shipmentIdController.text,
        shipmentStatus,
        shipmentOtp,
        file,
      );

      if (result) {
        status.value = Status.success;
        message.value = _repo.apiMessage ?? 'Upload successful';
        shipmentIdController.clear();

        Get.snackbar("Success", message.value,
            backgroundColor: themes.darkCyanBlue);
      } else {
        status.value = Status.error;
        message.value = _repo.apiMessage ?? 'Upload failed';
        Get.snackbar("Error", message.value, backgroundColor: themes.redColor);
      }
    } catch (e) {
      status.value = Status.error;
      message.value = 'Unexpected error: $e';
      Get.snackbar("Error", message.value, backgroundColor: themes.redColor);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    shipmentIdController.dispose();
  }
}
