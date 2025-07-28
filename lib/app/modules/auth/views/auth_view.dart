import 'dart:io';

import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final bottomController = Get.put(BottombarController());
    Themes themes = Themes();
    final Utils utils = Utils();

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
                spacing: 30,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
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
                  CommonTextfiled(
                    controller: authController.mobileController,
                    hintTxt: 'Phone number Or Email',
                    // keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    // prefixText: '+91 | ',
                    // lableText: '+91 | ',
                    validator: utils.validateText,
                  ),
                  Obx(
                    () {
                      return CommonTextfiled(
                          obscureText: authController.isObsecureText.value,
                          controller: authController.passwordController,
                          textInputAction: TextInputAction.done,
                          hintTxt: 'Enter your password',
                          validator: utils.validatePassword,
                          onSubmit: (value) => FocusScope.of(context).unfocus(),
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
                          ));
                    },
                  ),
                  Obx(() {
                    return CommonButton(
                      title: login,
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (authController.formKey.currentState?.validate() ==
                            true) {
                          authController.loginAuth(
                            controller.mobileController.text,
                            controller.passwordController.text,
                          );
                        }
                      },
                    );
                  }),

                  // Center(
                  //     child: Text(
                  //   'New to AMBEX Express.?',
                  //   style: themes.fontReboto16_600
                  //       .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  // )),
                  /*
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
                          onPressed: () {},
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
