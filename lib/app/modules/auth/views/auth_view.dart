import 'dart:io';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    // final authController = Get.put(AuthController());
    final bottomController = Get.put(BottombarController());
    Themes themes = Themes();
    final Utils utils = Utils();
    final authController = controller;

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              loginIMG,
            ),
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // spacing: 20,
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: Image.asset(
                      authLogo,
                      width: 100.w,
                    ),
                  ),
                  Text(
                    'Log into your Account',
                    style: themes.fontSize18_600
                        .copyWith(color: themes.darkCyanBlue),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Mobile field
                  CommonTextfiled(
                    controller: authController.mobileController,
                    hintTxt: 'Phone number Or Email',
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                    onChanged: (value) {
                      // This will trigger UI rebuild when mobile field changes
                      authController.mobileController.notifyListeners();
                    },
                  ),
                  Obx(
                    () => SizedBox(
                      height: authController.isOtpMode.value ? 0.h : 18.h,
                    ),
                  ),
                  // Password field (only show when NOT in OTP mode)
                  Obx(
                    () => !authController.isOtpMode.value
                        ? CommonTextfiled(
                            obscureText: authController.isObsecureText.value,
                            controller: authController.passwordController,
                            textInputAction: TextInputAction.done,
                            hintTxt: 'Enter your password',
                            validator: utils.validatePassword,
                            onSubmit: (value) =>
                                FocusScope.of(context).unfocus(),
                            sufixIcon: InkWell(
                              onTap: () {
                                authController.isObsecureText.value =
                                    !authController.isObsecureText.value;
                              },
                              child: Icon(
                                authController.isObsecureText.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  // SizedBox(
                  //   height: 18.h,
                  // ),
                  // "Login with OTP" text (only show when mobile is not empty AND not in OTP mode)
                  Obx(
                    () => SizedBox(
                      height: authController.isOtpMode.value ? 0.h : 10.h,
                    ),
                  ),
                  Obx(
                    () => !authController.isOtpMode.value &&
                            authController.mobileController.text
                                .trim()
                                .isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              authController.isOtpMode.value = true;
                              // Optionally send OTP here
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "Login with OTP",
                                style: TextStyle(
                                  color: themes.darkCyanBlue,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                  // SizedBox(
                  //   height: 5.h,
                  // ),
                  // OTP input section (only show when in OTP mode)
                  Obx(() => authController.isOtpMode.value
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: authController.secondsLeft.value > 0
                                ? null // Disable button when timer is running
                                : () {
                                    authController.sendOtp(
                                        authController.mobileController.text,
                                        '');
                                  },
                            child: Text(
                              authController.secondsLeft.value > 0
                                  ? "Resend OTP in ${authController.secondsLeft.value}s"
                                  : "Send OTP",
                              style: TextStyle(
                                color: authController.secondsLeft.value > 0
                                    ? themes.grayColor
                                    : themes.darkCyanBlue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )
                      : SizedBox()),
                  Obx(
                    () => authController.isOtpMode.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter the OTP sent to your phone',
                                style: themes.fontSize14_500
                                    .copyWith(color: Colors.grey),
                              ),
                              SizedBox(height: 10.h),
                              Pinput(
                                controller: authController.otpController,
                                length: 6,
                                defaultPinTheme: PinTheme(
                                  width: 40.w,
                                  height: 50.h,
                                  textStyle: themes.fontSize18_600
                                      .copyWith(fontSize: 20.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: themes.grayColor, width: 1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                focusedPinTheme: PinTheme(
                                  width: 40.w,
                                  height: 50.h,
                                  textStyle: themes.fontSize18_600
                                      .copyWith(fontSize: 20.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: themes.darkCyanBlue, width: 2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                submittedPinTheme: PinTheme(
                                  width: 40.w,
                                  height: 50.h,
                                  textStyle: themes.fontSize18_600
                                      .copyWith(fontSize: 20.sp),
                                  decoration: BoxDecoration(
                                    color: themes.grayColor.withOpacity(0.3),
                                    border: Border.all(
                                        color: themes.darkCyanBlue, width: 1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                showCursor: true,
                                onCompleted: (pin) {
                                  FocusScope.of(context).unfocus();
                                  // Optionally auto-verify OTP
                                  // authController.verifyOTP(pin);
                                },
                              ),
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    authController.isOtpMode.value = false;
                                    authController.otpController
                                        .clear(); // Clear OTP when switching back
                                  },
                                  child: Text(
                                    "Use Password Instead",
                                    style: TextStyle(
                                      color: themes.darkCyanBlue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                  ),

                  // Rest of your widgets (Terms & Conditions, Login Button, etc.)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() => Checkbox(
                            value: authController.isTermsAccepted.value,
                            onChanged: (value) {
                              authController.isTermsAccepted.value =
                                  value ?? false;
                            },
                            activeColor: themes.darkCyanBlue,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          )),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: themes.fontSize14_500.copyWith(
                              color: themes.blackColor,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => authController.urlLauncher(
                                    'https://axlpl.com/terms.html',
                                  ),
                                  child: Text(
                                    'Terms & Conditions',
                                    style: themes.fontSize14_500.copyWith(
                                      color: themes.darkCyanBlue,
                                      decoration: TextDecoration.underline,
                                      decorationColor: themes.darkCyanBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  // Login Button with dynamic title
                  Obx(() => authController.isOtpMode.value
                      ? CommonButton(
                          title: 'Verify OTP',
                          isLoading: authController.isVerifyingOtp.value ==
                              Status.loading,
                          backgroundColor: authController.isTermsAccepted.value
                              ? themes.darkCyanBlue
                              : themes.grayColor,
                          onPressed: authController.isTermsAccepted.value
                              ? () async {
                                  FocusScope.of(context).unfocus();

                                  if (authController.formKey.currentState
                                          ?.validate() ==
                                      true) {
                                    final otp = authController
                                        .otpController.text
                                        .trim();
                                    final mobile = authController
                                        .mobileController.text
                                        .trim();

                                    if (otp.length == 6) {
                                      await authController.verifyLoginOtp(
                                          mobile, otp);
                                    } else {
                                      Get.snackbar(
                                        'Invalid OTP',
                                        'Please enter a valid 6-digit OTP',
                                        backgroundColor: themes.redColor,
                                        colorText: themes.whiteColor,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    }
                                  }
                                }
                              : () {
                                  Get.snackbar(
                                    'Terms & Conditions Required',
                                    'Please accept the Terms & Conditions to continue',
                                    backgroundColor: themes.redColor,
                                    colorText: themes.whiteColor,
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(16),
                                    icon: Icon(
                                      Icons.warning_amber_rounded,
                                      color: themes.whiteColor,
                                    ),
                                  );
                                },
                        )
                      : CommonButton(
                          title: 'Login',
                          isLoading: authController.isLoading.value,
                          backgroundColor: authController.isTermsAccepted.value
                              ? themes.darkCyanBlue
                              : themes.grayColor,
                          onPressed: authController.isTermsAccepted.value
                              ? () async {
                                  FocusScope.of(context).unfocus();

                                  if (authController.formKey.currentState
                                          ?.validate() ==
                                      true) {
                                    await authController.loginAuth(
                                      authController.mobileController.text
                                          .trim(),
                                      authController.passwordController.text
                                          .trim(),
                                    );
                                    // }
                                  }
                                }
                              : () {
                                  Get.snackbar(
                                    'Terms & Conditions Required',
                                    'Please accept the Terms & Conditions to continue',
                                    backgroundColor: themes.redColor,
                                    colorText: themes.whiteColor,
                                    duration: const Duration(seconds: 3),
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: const EdgeInsets.all(16),
                                    icon: Icon(
                                      Icons.warning_amber_rounded,
                                      color: themes.whiteColor,
                                    ),
                                  );
                                },
                        )),
                  SizedBox(
                    height: 15.h,
                  ),
                  // Rest of your widgets...
                  Center(
                    child: Text(
                      'New to AMBEX Express.?',
                      style: themes.fontReboto16_600.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Center(
                        child: CupertinoButton(
                          color: themes.orangeColor,
                          focusColor: themes.whiteColor,
                          borderRadius: BorderRadius.circular(5.r),
                          child: Text(
                            registerNow,
                            style: themes.fontReboto16_600
                                .copyWith(color: themes.whiteColor),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.REGISTER);
                          },
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
