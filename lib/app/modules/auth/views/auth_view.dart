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

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    Themes themes = Themes();
    return Scaffold(
      body: SingleChildScrollView(
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
                      width: 210.w,
                    ),
                  ),
                  Text(
                    'Log into your Account',
                    style: themes.fontSize18_600
                        .copyWith(color: themes.darkCyanBlue),
                  ),
                  CommomTextfiled(
                      controller: authController.mobileController,
                      hintTxt: 'Enter your Phone Number',
                      keyboardType: TextInputType.phone,
                      prefixText: '+91 | ',
                      validator: (p0) {
                        if (p0!.isEmpty || p0.length < 10) {
                          return 'Please enter your mobile numer';
                        }
                        return null;
                      }),
                  Obx(
                    () {
                      return CommomTextfiled(
                          obscureText: authController.isObsecureText.value,
                          controller: authController.passwordController,
                          hintTxt: 'Enter your password',
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          sufixIcon: InkWell(
                            onTap: () {
                              authController.isObsecureText.value =
                                  !authController.isObsecureText.value;
                            },
                            child: Icon(authController.isObsecureText.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                          ));
                    },
                  ),
                  CommonButton(
                    title: login,
                    onPressed: () {
                      if (authController.formKey.currentState!.validate()) {
                        Get.offAllNamed(Routes.BOTTOMBAR);
                      } else {
                        Get.snackbar('Error', 'Please fill all the fields',
                            backgroundColor: themes.redColor);
                      }
                    },
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password ?',
                        style:
                            TextStyle(color: themes.shineBlue, fontSize: 14.sp),
                      )),
                  Center(
                      child: Text(
                    'New to AMBEX Express.?',
                    style: themes.fontReboto16_600
                        .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  )),
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
