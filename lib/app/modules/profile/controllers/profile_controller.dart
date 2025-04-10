import 'dart:io';

import 'package:axlpl_delivery/app/data/networking/repostiory/profile_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final profileRepo = ProfileRepo();
  RxBool isEdit = false.obs;
  var imageFile = Rx<File?>(null);
  var errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  var isPsswordChange = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  void editProfile() {
    isEdit.value = !isEdit.value; // Toggle editing state
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera'),
              onPressed: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            TextButton(
              child: const Text('Gallery'),
              onPressed: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> changePassword() async {
    errorMessage.value = '';
    successMessage.value = '';
    isPsswordChange.value = true;

    final oldPass = oldPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass != confirmPass) {
      isPsswordChange.value = false;
      errorMessage.value = 'New and confirm passwords do not match';
      return;
    }

    final result = await profileRepo.changePassword(oldPass, newPass);

    isPsswordChange.value = false;

    if (result) {
      successMessage.value = 'Password changed successfully';
      Get.back();
      Get.snackbar(result.toString(), 'Password changed successfully',
          backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
    } else {
      errorMessage.value = 'Failed to change password';
      Get.back();
      Get.snackbar(result.toString(), errorMessage.toString(),
          backgroundColor: themes.redColor, colorText: themes.whiteColor);
    }
  }

  void clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
