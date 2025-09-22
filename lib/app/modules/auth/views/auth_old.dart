//old

//  return Scaffold(
//       body: SingleChildScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//             fit: BoxFit.cover,
//             image: AssetImage(
//               loginIMG,
//             ),
//           )),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Form(
//                 key: authController.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 20,
//                   children: [
//                     SizedBox(
//                       height: 40.h,
//                     ),
//                     Center(
//                       child: Image.asset(
//                         authLogo,
//                         width: 100.w,
//                       ),
//                     ),
//                     Text(
//                       'Log into your Account',
//                       style: themes.fontSize18_600
//                           .copyWith(color: themes.darkCyanBlue),
//                     ),
//                     CommonTextfiled(
//                       controller: authController.mobileController,
//                       hintTxt: 'Phone number Or Email',
//                       // keyboardType: TextInputType.phone,
//                       textInputAction: TextInputAction.next,
//                       // prefixText: '+91 | ',
//                       // lableText: '+91 | ',
//                       validator: utils.validateText,
//                     ),
//                     Obx(
//                       () => !authController.isOtpMode.value &&
//                               authController.mobileController.text
//                                   .trim()
//                                   .isNotEmpty
//                           ? GestureDetector(
//                               onTap: () {
//                                 authController.isOtpMode.value = true;
//                               },
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 8),
//                                 child: Text(
//                                   "Login with OTP",
//                                   style: TextStyle(
//                                     color: themes.darkCyanBlue,
//                                     fontWeight: FontWeight.bold,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : CommonTextfiled(
//                               obscureText: authController.isObsecureText.value,
//                               controller: authController.passwordController,
//                               textInputAction: TextInputAction.done,
//                               hintTxt: 'Enter your password',
//                               validator: utils.validatePassword,
//                               onSubmit: (value) =>
//                                   FocusScope.of(context).unfocus(),
//                               sufixIcon: InkWell(
//                                 onTap: () {
//                                   authController.isObsecureText.value =
//                                       !authController.isObsecureText.value;
//                                 },
//                                 child: Icon(
//                                   authController.isObsecureText.value
//                                       ? Icons.visibility_off
//                                       : Icons.visibility,
//                                 ),
//                               )),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Obx(() => Padding(
//                               padding: const EdgeInsets.only(top: 0),
//                               child: Checkbox(
//                                 value: authController.isTermsAccepted.value,
//                                 onChanged: (value) {
//                                   authController.isTermsAccepted.value =
//                                       value ?? false;
//                                 },
//                                 activeColor: themes.darkCyanBlue,
//                                 materialTapTargetSize:
//                                     MaterialTapTargetSize.shrinkWrap,
//                               ),
//                             )),
//                         Expanded(
//                           child: RichText(
//                             text: TextSpan(
//                               style: themes.fontSize14_500.copyWith(
//                                 color: themes.blackColor,
//                               ),
//                               children: [
//                                 const TextSpan(text: 'I agree to the '),
//                                 WidgetSpan(
//                                   child: GestureDetector(
//                                     onTap: () => authController.urlLauncher(
//                                       'https://axlpl.com/terms.html',
//                                     ),
//                                     child: Text(
//                                       'Terms & Conditions',
//                                       style: themes.fontSize14_500.copyWith(
//                                         color: themes.darkCyanBlue,
//                                         decoration: TextDecoration.underline,
//                                         decorationColor: themes.darkCyanBlue,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Obx(() {
//                       return CommonButton(
//                         title: login,
//                         isLoading: controller.isLoading.value,
//                         // Visual feedback for disabled state
//                         backgroundColor: authController.isTermsAccepted.value
//                             ? themes.darkCyanBlue
//                             : themes.grayColor,
//                         onPressed: authController.isTermsAccepted.value
//                             ? () async {
//                                 FocusScope.of(context).unfocus();
//                                 if (authController.formKey.currentState
//                                         ?.validate() ==
//                                     true) {
//                                   authController.loginAuth(
//                                     controller.mobileController.text,
//                                     controller.passwordController.text,
//                                   );
//                                 }
//                               }
//                             : () {
//                                 Get.snackbar(
//                                   'Terms & Conditions Required',
//                                   'Please accept the Terms & Conditions to continue',
//                                   backgroundColor: themes.redColor,
//                                   colorText: themes.whiteColor,
//                                   duration: const Duration(seconds: 3),
//                                   snackPosition: SnackPosition.BOTTOM,
//                                   margin: const EdgeInsets.all(16),
//                                   icon: Icon(
//                                     Icons.warning_amber_rounded,
//                                     color: themes.whiteColor,
//                                   ),
//                                 );
//                               },
//                       );
//                     }),
//                     Center(
//                         child: Text(
//                       'New to AMBEX Express.?',
//                       style: themes.fontReboto16_600.copyWith(
//                           fontSize: 14.sp, fontWeight: FontWeight.w400),
//                     )),
//                     Row(
//                       children: [
//                         Expanded(child: Divider()),
//                         Center(
//                           child: CupertinoButton(
//                             color: themes.orangeColor,
//                             focusColor: themes.whiteColor,
//                             borderRadius: BorderRadius.circular(5.r),
//                             child: Text(
//                               registerNow,
//                               style: themes.fontReboto16_600
//                                   .copyWith(color: themes.whiteColor),
//                             ),
//                             onPressed: () {
//                               Get.toNamed(
//                                 Routes.REGISTER,
//                               );
//                             },
//                           ),
//                         ),
//                         Expanded(child: Divider()),
//                       ],
//                     ),
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );

/*  Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(loginIMG),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: authController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
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

                  // PHONE FIELD
                  CommonTextfiled(
                    controller: authController.mobileController,
                    hintTxt: 'Phone number Or Email',
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                    onChanged: (value) =>
                        authController.onPhoneChanged(value ?? ''),
                  ),

                  // PASSWORD vs OTP FLOW
                  Obx(() {
                    if (!authController.isOtpMode.value) {
                      final hasPhone = authController.mobileController.text
                          .trim()
                          .isNotEmpty;
                      if (hasPhone &&
                          authController.otpStep.value == OtpStep.readyToSend) {
                        return GestureDetector(
                          onTap: authController.enterOtpMode,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Login with OTP",
                              style: TextStyle(
                                color: themes.darkCyanBlue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        );
                      }
                      return CommonTextfiled(
                        obscureText: authController.isObsecureText.value,
                        controller: authController.passwordController,
                        textInputAction: TextInputAction.done,
                        hintTxt: 'Enter your password',
                        validator: utils.validatePassword,
                        onSubmit: (value) => FocusScope.of(context).unfocus(),
                        sufixIcon: InkWell(
                          onTap: () => authController.isObsecureText.value =
                              !authController.isObsecureText.value,
                          child: Icon(
                            authController.isObsecureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    }

                    // In OTP mode
                    if (authController.otpStep.value == OtpStep.readyToSend) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonButton(
                            title: 'Send OTP',
                            isLoading: authController.isSendingOtp.value,
                            // onPressed: () {},
                            onPressed: authController.isSendingOtp.value
                                ? null
                                : authController.sendOtp,
                            backgroundColor: themes.darkCyanBlue,
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: authController.backToPassword,
                            child: Text(
                              'Use password instead',
                              style: TextStyle(
                                color: themes.darkCyanBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    // Code sent → show Pinput + Verify
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Enter the 4-digit code sent to your phone',
                          style: themes.fontSize14_500,
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Pinput(
                            length: 4,
                            controller: authController.otpController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            onCompleted: (_) =>
                                FocusScope.of(context).unfocus(),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                title: 'Verify OTP',
                                isLoading: authController.isVerifyingOtp.value,
                                onPressed: authController.isVerifyingOtp.value
                                    ? null
                                    : authController.verifyOtp,
                                backgroundColor: themes.darkCyanBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() {
                          final left = authController.secondsLeft.value;
                          final canResend = left == 0;
                          return Row(
                            children: [
                              if (!canResend)
                                Text('Resend in ${left}s',
                                    style: themes.fontSize14_500),
                              if (canResend)
                                TextButton(
                                  onPressed: authController.sendOtp,
                                  child: const Text('Resend OTP'),
                                ),
                              const Spacer(),
                              GestureDetector(
                                onTap: authController.backToPassword,
                                child: Text(
                                  'Use password instead',
                                  style: TextStyle(
                                    color: themes.darkCyanBlue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  }),

                  // Terms Checkbox
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
                            style: themes.fontSize14_500
                                .copyWith(color: themes.blackColor),
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

                  // Main Login button only for password flow
                  Obx(() {
                    final showMainLogin = !authController.isOtpMode.value;
                    if (!showMainLogin) return const SizedBox.shrink();

                    return CommonButton(
                      title: login,
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
                                authController.loginAuth(
                                  authController.mobileController.text,
                                  authController.passwordController.text,
                                );
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
                                icon: Icon(Icons.warning_amber_rounded,
                                    color: themes.whiteColor),
                              );
                            },
                    );
                  }),

                  Center(
                    child: Text(
                      'New to AMBEX Express.?',
                      style: themes.fontReboto16_600.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
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
                      const Expanded(child: Divider()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );*/
