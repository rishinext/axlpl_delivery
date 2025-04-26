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
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();
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

      if (profileData is Customerdetail) {
        customerDetail.value = profileData;
        messangerDetail.value = null;

        nameController.text = profileData.fullName ?? '';
        codeController.text = profileData.companyName ?? '';
        stateController.text = profileData.stateName ?? '';
        cityController.text = profileData.cityName ?? '';
        branchController.text = profileData.branchName ?? '';
        address1Controller.text = profileData.regAddress1 ?? '';
        address2Controller.text = profileData.regAddress2 ?? '';
        pincodeController.text = profileData.pincode ?? '';
        phoneController.text = profileData.mobileNo ?? '';
        emailController.text = profileData.email ?? '';
        vehicleController.text =
            profileData.natureBusiness ?? ''; // business nature for customer

        // axlInsuranceController.text = profileData.axlplInsuranceValue ?? '';
        // thirdPartyInsuranceController.text =
        //     profileData.thirdPartyInsuranceValue ?? '';
        // thirdPartyPolicyNoController.text =
        //     profileData.thirdPartyPolicyNo ?? '';
        // thirdPartyExpiryController.text =
        //     profileData.thirdPartyExpDate?.toIso8601String().split("T")[0] ??
        //         '';

        isProfileLoading.value = Status.success;
      } else if (profileData is MessangersDetailsModel) {
        messangerDetail.value = profileData;
        customerDetail.value = null;

        nameController.text = profileData.messangerdetail?.name ?? '';
        codeController.text = profileData.messangerdetail?.code ?? '';
        stateController.text = profileData.messangerdetail?.stateName ?? '';
        cityController.text = profileData.messangerdetail?.cityName ?? '';
        branchController.text = profileData.messangerdetail?.branchName ?? '';
        phoneController.text = profileData.messangerdetail?.phone ?? '';
        emailController.text = profileData.messangerdetail?.email ?? '';
        routeController.text = profileData.messangerdetail?.routeCode ?? '';
        vehicleController.text = profileData.messangerdetail?.vehicleNo ?? '';

        isProfileLoading.value = Status.success;
      }
    } catch (e) {
      Utils.instance.log("Error fetching profile: $e");
      errorMessage.value = 'Failed to fetch profile data';
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
      );
      if (result) {
        await fetchProfileData();
        isUpdateProfile.value = Status.success;
        Get.snackbar(result.toString(), 'Profile updated successfully',
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        isUpdateProfile.value = Status.error;
        Get.snackbar(result.toString(), 'Failed to update profile',
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      Utils.instance.log("Error updating profile: $e");
      isUpdateProfile.value = Status.error;
      errorMessage.value = 'Failed to update profile';
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
