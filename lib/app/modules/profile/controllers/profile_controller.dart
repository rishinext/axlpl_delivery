import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/models/profile_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/profile_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final profileRepo = ProfileRepo();
  var messangerDetail = Rxn<MessangersDetailsModel>();
  var customerDetail = Rxn<Customerdetail>();

  RxBool isEdit = false.obs;
  var imageFile = Rx<File?>(null);
  var errorMessage = ''.obs;
  final RxString successMessage = ''.obs;
  var isPsswordChange = false.obs;

  var isProfileLoading = Status.initial.obs;
  var isUpdateProfile = Status.initial.obs;
  var isRatting = Status.initial.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController shipmentIDController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  var rating = 0.0.obs;

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

  Future<void> fetchProfileData() async {
    errorMessage.value = '';
    isProfileLoading.value = Status.loading;

    try {
      final profileData = await profileRepo.editProfile();

      // Debugging logs
      log('Profile Data Type: ${profileData.runtimeType}');
      log('Raw Profile Data: $profileData');

      if (profileData == null) {
        errorMessage.value = 'No profile data received from server';
        isProfileLoading.value = Status.error;
        return;
      }

      if (profileData is Customerdetail) {
        customerDetail.value = profileData;
        messangerDetail.value = null;

        // Null-aware assignments with fallback
        nameController.text = profileData.fullName ?? '';
        codeController.text = profileData.companyName ?? '';
        stateController.text = profileData.stateName ?? '';
        cityController.text = profileData.cityName ?? '';
        cateController.text = profileData.category ?? '';
        branchController.text = profileData.branchName ?? '';
        address1Controller.text = profileData.regAddress1 ?? '';
        address2Controller.text = profileData.regAddress2 ?? '';
        pincodeController.text = profileData.pincode ?? '';
        phoneController.text = profileData.mobileNo ?? '';
        emailController.text = profileData.email ?? '';
        vehicleController.text = profileData.natureBusiness ?? '';

        isProfileLoading.value = Status.success;
      } else if (profileData is MessangersDetailsModel) {
        messangerDetail.value = profileData;
        customerDetail.value = null;

        // Using null-safe access operator
        final messenger = profileData.messangerdetail;
        nameController.text = messenger?.name ?? '';
        codeController.text = messenger?.code ?? '';
        stateController.text = messenger?.stateName ?? '';
        cityController.text = messenger?.cityName ?? '';
        branchController.text = messenger?.branchName ?? '';
        phoneController.text = messenger?.phone ?? '';
        emailController.text = messenger?.email ?? '';
        routeController.text = messenger?.routeCode ?? '';
        vehicleController.text = messenger?.vehicleNo ?? '';

        isProfileLoading.value = Status.success;
      } else {
        errorMessage.value =
            'Unexpected data format: ${profileData.runtimeType}';
        isProfileLoading.value = Status.error;
      }
    } catch (e, stackTrace) {
      Utils.instance
          .log("Error fetching profile: $e\nStack Trace: $stackTrace");
      errorMessage.value = 'Failed to fetch profile data: ${e.toString()}';
      isProfileLoading.value = Status.error;
    }
  }

  Future<void> updateProfile() async {
    errorMessage.value = '';
    isUpdateProfile.value = Status.loading;
    try {
      final result = await profileRepo.updateProfile(
        nameController.text,
        emailController.text,
        phoneController.text,
        imageFile,
      );
      if (result) {
        await fetchProfileData();
        isUpdateProfile.value = Status.success;
        Get.snackbar('', 'Profile updated successfully',
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        isUpdateProfile.value = Status.error;
        Get.snackbar('', 'Failed to update profile',
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      Utils.instance.log("Error updating profile: $e");
      isUpdateProfile.value = Status.error;
      errorMessage.value = 'Failed to update profile';
    }
  }

  Future<void> rateMessanger() async {
    errorMessage.value = '';
    isRatting.value = Status.loading;
    try {
      final result = await profileRepo.rateMessangerRepo(
        // shipmentIDController.text,
        '221644046941',
        rating.value,
        feedbackController.text,
      );
      if (result) {
        isRatting.value = Status.success;
        Get.snackbar(result.toString(), 'Feedback successfully',
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        isRatting.value = Status.error;
        Get.snackbar(result.toString(), 'Failed to Feedaback',
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      Utils.instance.log("Error Feedaback: $e");
      isRatting.value = Status.error;
      errorMessage.value = 'Failed to Feedaback';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProfileData();
  }
}
