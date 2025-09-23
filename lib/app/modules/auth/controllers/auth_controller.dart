import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/auth_repo.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

enum OtpStep { idle, readyToSend, codeSent }

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final AuthRepo _authRepo = AuthRepo();

  final formKey = GlobalKey<FormState>();

  LocalStorage localStorage = LocalStorage();

  final verifyOtpmessage = ''.obs;

  RxBool isObsecureText = true.obs;
  RxBool isTermsAccepted = false.obs;
  var isLoading = false.obs;
  final isSendingOtp = false.obs;
  final secondsLeft = 0.obs;
  final isVerifyingOtp = Status.initial.obs;

  var errorMessage = ''.obs;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final otpController = TextEditingController();

  final profileController = Get.put(ProfileController());

  final isOtpMode = false.obs; // toggles password vs OTP UI
  final otpStep = OtpStep.idle.obs; // idle -> readyToSend -> codeSent

  Timer? _timer;

  Future<void> loginAuth(
    String mobile,
    String password,
  ) async {
    isLoading.value = true;
    try {
      await _authRepo.loginRepo(
        mobile,
        password,
      );
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
      log(errorMessage.value);
      Get.snackbar('', errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp(
    String mobile,
    String otp,
  ) async {
    isSendingOtp.value = true;
    // Start timer immediately when OTP is sent
    _startTimer(30);
    try {
      final sendingOtp = await _authRepo.loginRepo(
        mobile,
        otp,
      );
      if (sendingOtp) {
        otpStep.value = OtpStep.codeSent;
      } else {
        errorMessage.value = _authRepo.apiMessage ?? 'Sending OTP failed';
        Get.snackbar(
          '',
          errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      log(errorMessage.value);
      Get.snackbar('', errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isSendingOtp.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (secondsLeft.value != 0) return;
    await sendOtp(
      mobileController.text,
      otpController.text,
    ); // reuses the same flow + restarts timer
  }

  Future<void> verifyLoginOtp(
    String mobile,
    String otp,
  ) async {
    isVerifyingOtp.value = Status.loading;
    verifyOtpmessage.value = '';
    try {
      await _authRepo.verifyLoginOtpRepo(
        mobile,
        otp,
      );
      final role = await storage.read(key: localStorage.userRole);
      if (role == 'messanger') {
        isVerifyingOtp.value = Status.success;
        Get.offAllNamed(Routes.HOME);
        profileController.fetchProfileData();
      } else if (role == 'customer') {
        isVerifyingOtp.value = Status.success;
        Get.offAllNamed(Routes.HOME);
        profileController.fetchProfileData();
      } else {
        isVerifyingOtp.value = Status.error;
        verifyOtpmessage.value = _authRepo.apiMessage ?? 'Verification failed';
        Get.snackbar(
          'Error',
          verifyOtpmessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      isVerifyingOtp.value = Status.error;
      // Get the clean error message from repository
      verifyOtpmessage.value = _authRepo.apiMessage ?? "Verification failed";
      log('OTP Verification Error: ${verifyOtpmessage.value}');
      Get.snackbar(
        'Error',
        verifyOtpmessage.value,
        colorText: themes.whiteColor,
        backgroundColor: themes.redColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
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
      Get.snackbar('', errorMessage.value,
          colorText: themes.whiteColor,
          backgroundColor: themes.redColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> urlLauncher(final urlLink) async {
    try {
      final Uri url = Uri.parse(urlLink);

      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback: Show a snackbar with the URL if launching fails
        Get.snackbar(
          'error',
          'Visit: $urlLink',
          backgroundColor: Themes().darkCyanBlue,
          colorText: Themes().whiteColor,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      }
    } catch (e) {
      // Error handling: Show error message
      Get.snackbar(
        'Error',
        'Unable to open Terms & Conditions. Please visit axlpl.com/terms.html',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
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

    mobileController.addListener(() {
      if (!isOtpMode.value) {
        final hasPhone = mobileController.text.trim().isNotEmpty;
        otpStep.value = hasPhone ? OtpStep.readyToSend : OtpStep.idle;
      }
    });
    super.dispose();
  }

  @override
  void onClose() {
    _cancelTimer();
    // mobileController.dispose();
    // passwordController.dispose();
    // otpController.dispose();
    super.onClose();
  }

  onPhoneChanged(String? _) {
    if (!isOtpMode.value) {
      otpStep.value = mobileController.text.trim().isNotEmpty
          ? OtpStep.readyToSend
          : OtpStep.idle;
    }
  }

  /// Switch from password to OTP mode and show "Send OTP".
  void enterOtpMode() {
    isOtpMode.value = true;
    otpStep.value = OtpStep.readyToSend;
  }

  /// Go back to password login.
  void backToPassword() {
    isOtpMode.value = false;
    otpStep.value = OtpStep.idle;
    otpController.clear();
    _cancelTimer();
  }

  void _startTimer(int seconds) {
    secondsLeft.value = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft.value <= 1) {
        t.cancel();
        secondsLeft.value = 0;
      } else {
        secondsLeft.value -= 1;
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    secondsLeft.value = 0;
  }
}
