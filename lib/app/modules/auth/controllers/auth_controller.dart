import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final AuthRepo _authRepo = AuthRepo();

  final formKey = GlobalKey<FormState>();

  LocalStorage localStorage = LocalStorage();

  RxBool isObsecureText = true.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final profileController = Get.put(ProfileController());
  Future<void> loginAuth(
    String mobile,
    String password,
  ) async {
    isLoading.value = true;
    try {
      await _authRepo.loginRepo(mobile, password);
      final role = await storage.read(key: localStorage.userRole);
      if (role == 'messanger') {
        // Get.offAllNamed(Routes.BOTTOMBAR, arguments: '');
        Get.offAllNamed(Routes.HOME);
        profileController.fetchProfileData();
      } else if (role == 'customer') {
        // Get.offAllNamed(Routes.BOTTOMBAR, arguments: '');
        Get.offAllNamed(Routes.HOME);
        profileController.fetchProfileData();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    isLoading.value = true;
    try {
      final isLogout = await _authRepo.logoutRepo();
      if (isLogout) {
        Get.offAllNamed(Routes.AUTH);
        // Get.forceAppUpdate();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      } else {
        status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    // For other platforms like iOS, assume permission is granted or handled elsewhere.
    return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
