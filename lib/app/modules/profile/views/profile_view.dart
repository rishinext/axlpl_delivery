import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
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
    var data = Get.arguments;
    return CommonScaffold(
        appBar: commonAppbar('Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10.h,
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 60,
                          backgroundImage: controller.imageFile.value != null
                              ? FileImage(controller.imageFile.value!)
                              : null,
                          child: controller.imageFile.value == null
                              ? Icon(Icons.camera_alt,
                                  color: themes.whiteColor, size: 50)
                              : null,
                        );
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.h, left: 60.w),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.camera_circle,
                          size: 35,
                        ),
                        onPressed: () =>
                            controller.showImageSourceDialog(context),
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
                              Obx(() {
                                return controller.isEdit.value
                                    ? TextButton.icon(
                                        style: TextButton.styleFrom(
                                            foregroundColor: themes.whiteColor,
                                            backgroundColor:
                                                themes.darkCyanBlue),
                                        icon: Icon(
                                          Icons.save,
                                          color: themes.whiteColor,
                                        ),
                                        onPressed: controller.editProfile,
                                        label: Text(
                                          'Save',
                                          style: themes.fontSize14_500.copyWith(
                                            fontSize: 16.sp,
                                          ),
                                        ))
                                    : TextButton.icon(
                                        icon: Icon(
                                          CupertinoIcons.square_pencil_fill,
                                          color: themes.grayColor,
                                        ),
                                        onPressed: controller.editProfile,
                                        label: Text(
                                          'Edit',
                                          style: themes.fontSize14_500.copyWith(
                                              fontSize: 16.sp,
                                              color: themes.grayColor),
                                        ));
                              })
                            ],
                          ),
                          Text(
                            yourName,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: yourName,
                              isEnable: controller.isEdit.value,
                              controller: controller.nameController,
                            );
                          }),
                          Text(
                            'Code',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: 'AXL- 033',
                              isEnable: controller.isEdit.value,
                              controller: controller.codeController,
                            );
                          }),
                          Text(
                            state,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: state,
                              isEnable: controller.isEdit.value,
                              controller: controller.stateController,
                            );
                          }),
                          Text(
                            city,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: city,
                              isEnable: controller.isEdit.value,
                              controller: controller.cityController,
                            );
                          }),
                          Text(
                            branch,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: branch,
                              isEnable: controller.isEdit.value,
                              controller: controller.branchController,
                            );
                          }),
                          Text(
                            'Route',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: 'AXL- 033',
                              isEnable: controller.isEdit.value,
                              controller: controller.routeController,
                            );
                          }),
                          Text(
                            mobile,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              isEnable: controller.isEdit.value,
                              hintTxt: '98888888',
                              controller: controller.phoneController,
                            );
                          }),
                          Text(
                            email,
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: email,
                              isEnable: controller.isEdit.value,
                              controller: controller.emailController,
                            );
                          }),
                          Text(
                            'Vehicle No',
                            style: themes.fontSize14_500
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          Obx(() {
                            return CommomTextfiled(
                              hintTxt: '0555',
                              isEnable: controller.isEdit.value,
                              controller: controller.vehicleController,
                            );
                          }),
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
                          keyIcon,
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
                          privacyIcon,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: InkWell(
                    onTap: () {
                      LocalStorage().clearAll();
                      Get.offAllNamed(Routes.AUTH);
                    },
                    child: ListTile(
                        tileColor: themes.whiteColor,
                        dense: false,
                        leading: CircleAvatar(
                            backgroundColor: themes.blueGray,
                            child: Icon(
                              Icons.logout_sharp,
                              color: themes.blackColor,
                            )),
                        title: Text('Logout'),
                        trailing: CircleAvatar(
                          backgroundColor: themes.lightCream,
                          // radius: 15,
                          child: Icon(
                            Icons.arrow_forward,
                            size: 20.w,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
