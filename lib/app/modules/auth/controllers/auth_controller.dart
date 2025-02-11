import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<void> loginUser(
    String mobile,
    String password,
  ) async {
    isLoading.value = true;
    try {
      final isLoggedIn = await _authRepo.loginRepo(mobile, password);
      if (isLoggedIn) {
        final usersData = await _authRepo.getUserLocalData();
        Get.offAllNamed(Routes.BOTTOMBAR, arguments: usersData);
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
