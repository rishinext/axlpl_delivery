import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/manimg.png'),
                      ),
                    ),
                    Positioned(
                      top: 70.h,
                      bottom: 50,
                      left: 85.w,
                      right: 50,
                      child: Icon(
                        CupertinoIcons.camera_circle,
                        size: 35,
                        color: themes.whiteColor,
                      ),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    'Biju Dahal',
                    style: themes.fontReboto16_600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: themes.whiteColor,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10),
                      child: Column(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Profile Info',
                                style: themes.fontSize18_600
                                    .copyWith(fontSize: 16.sp),
                              ),
                              Spacer(),
                              Icon(
                                CupertinoIcons.square_pencil_fill,
                                color: themes.grayColor,
                              ),
                              Text(
                                'Edit',
                                style: themes.fontSize14_500.copyWith(
                                    fontSize: 16.sp, color: themes.grayColor),
                              )
                            ],
                          ),
                          Text(
                            yourName,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: yourName,
                          ),
                          Text(
                            'Code',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: 'AXL- 033',
                          ),
                          Text(
                            state,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: state,
                          ),
                          Text(
                            city,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: city,
                          ),
                          Text(
                            branch,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: branch,
                          ),
                          Text(
                            'Route',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: 'AXL- 033',
                          ),
                          Text(
                            mobile,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: '98888888',
                          ),
                          Text(
                            email,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: email,
                          ),
                          Text(
                            'Vehicle No',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          CommomTextfiled(
                            hintTxt: '0555',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Settings',
                    style: themes.fontSize18_600.copyWith(fontSize: 16.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListTile(
                      tileColor: themes.whiteColor,
                      dense: false,
                      leading: CircleAvatar(
                        backgroundColor: themes.blueGray,
                        child: Image.asset(
                          gpsIcon,
                          width: 18.w,
                        ),
                      ),
                      title: Text(changePass),
                      trailing: CircleAvatar(
                        backgroundColor: themes.lightCream,
                        // radius: 15,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20.w,
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ListTile(
                      tileColor: themes.whiteColor,
                      dense: false,
                      leading: CircleAvatar(
                        backgroundColor: themes.blueGray,
                        child: Image.asset(
                          gpsIcon,
                          width: 18.w,
                        ),
                      ),
                      title: Text(privacy),
                      trailing: CircleAvatar(
                        backgroundColor: themes.lightCream,
                        // radius: 15,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20.w,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
