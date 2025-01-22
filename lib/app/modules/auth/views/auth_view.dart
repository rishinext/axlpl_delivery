import 'package:axlpl_delivery/common_widget/common_textfileddart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
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
                // CommomTextfiled(),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle:
                        themes.fontSize16_400.copyWith(color: themes.grayColor),
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: themes.darkCyanBlue,
                    focusColor: themes.whiteColor,
                    borderRadius: BorderRadius.circular(20.r),
                    child: Text(
                      login,
                      style: themes.fontReboto16_600
                          .copyWith(color: themes.whiteColor),
                    ),
                    onPressed: () {},
                  ),
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
    );
  }
}
