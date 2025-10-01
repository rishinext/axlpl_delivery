import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/models/profile_data_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/profile_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  var isDeleteAccount = false.obs;

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
    if (Platform.isIOS) {
      // iOS Cupertino Action Sheet
      return showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              'Select Image Source',
              style: TextStyle(fontSize: 14.sp),
            ),
            message: const Text(
              'Choose where to pick your profile image from',
              style: TextStyle(fontSize: 14),
            ),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.camera, size: 20),
                    SizedBox(width: 8),
                    Text('Camera'),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.photo, size: 20),
                    SizedBox(width: 8),
                    Text('Photo Library'),
                  ],
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          );
        },
      );
    } else {
      // Android Material Dialog
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.image, color: Colors.blue),
                SizedBox(width: 12),
                Text(
                  'Select Image Source',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
            content: const Text('Choose where to pick your profile image from'),
            actions: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera_alt, size: 20),
                label: const Text('Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: const Icon(Icons.photo_library, size: 20),
                label: const Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        },
      );
    }
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
      Get.snackbar('Success', 'Password changed successfully',
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
    isUpdateProfile.value = Status.loading;
    try {
      // Handle image file for both iOS and Android
      dynamic photoParam;
      if (imageFile.value != null) {
        // Check if file exists and is readable
        if (await imageFile.value!.exists()) {
          photoParam = imageFile.value; // File object
          log("New photo selected: ${photoParam!.path}");
          log("File size: ${await photoParam.length()} bytes");
        } else {
          log("Selected file does not exist");
          photoParam = null;
        }
      } else {
        // For iOS compatibility, pass existing photo string instead of null
        if (Platform.isIOS) {
          photoParam = messangerDetail.value?.messangerdetail?.photo ?? '';
          log("iOS: Keeping existing photo: $photoParam");
        } else {
          photoParam = null;
          log("Android: No new photo selected, keeping existing photo");
        }
      }

      final result = await profileRepo.updateProfile(
        nameController.text,
        emailController.text,
        phoneController.text,
        photoParam,
      );

      if (result) {
        // Clear the image file after successful update
        imageFile.value = null;
        await fetchProfileData();
        isUpdateProfile.value = Status.success;
        Get.snackbar('Success', 'Profile updated successfully',
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      Utils.instance.log("Error updating profile: $e");
      isUpdateProfile.value = Status.error;
      errorMessage.value = 'Failed to update profile: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value,
          backgroundColor: themes.redColor, colorText: themes.whiteColor);
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

  Future<void> deleteAccount() async {
    errorMessage.value = '';
    isDeleteAccount.value = true;

    try {
      final result = await profileRepo.deleteAccountRepo();

      if (result) {
        successMessage.value = 'Account deleted successfully';
        Get.back();
        Get.snackbar('', 'Account deleted successfully',
            backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      } else {
        errorMessage.value = 'Failed to delete account';
        Get.back();
        Get.snackbar('', errorMessage.toString(),
            backgroundColor: themes.redColor, colorText: themes.whiteColor);
      }
    } catch (e) {
      Utils.instance.log("Error deleting account: $e");
      errorMessage.value = 'Failed to delete account';
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
