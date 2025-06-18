import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/auth/controllers/auth_controller.dart';
import 'package:axlpl_delivery/common_widget/change_password_dialog.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/common_widget/common_tow_btn_dialog.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../bottombar/controllers/bottombar_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomController = Get.put(BottombarController());
    final authController = Get.put(AuthController());
    final profileController = Get.put(ProfileController());
    final user = bottomController.userData.value;

    return CommonScaffold(
        appBar: commonAppbar('Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Obx(() {
                    return controller.isEdit.value
                        ? TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor: themes.whiteColor,
                                backgroundColor: themes.darkCyanBlue),
                            icon: Icon(
                              Icons.save,
                              color: themes.whiteColor,
                            ),
                            onPressed: () {
                              controller.editProfile;
                              controller.updateProfile();
                            },
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
                                color: themes.grayColor,
                              ),
                            ));
                  }),
                ),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Obx(() {
                        final imageFile = controller.imageFile.value;
                        final imageUrl =
                            "${controller.messangerDetail.value?.messangerdetail?.path ?? ''}${controller.messangerDetail.value?.messangerdetail?.photo ?? ''}";
                        final custImg =
                            "${controller.customerDetail.value?.path ?? ''}${controller.customerDetail.value?.custProfileImg ?? ''}";

                        return CircleAvatar(
                          radius: 62,
                          backgroundColor: themes.darkCyanBlue,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: themes.whiteColor,
                            child: imageFile == null && imageUrl.isEmpty
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                                    color: themes.darkCyanBlue,
                                  )
                                : null,
                            backgroundImage: imageFile != null
                                ? FileImage(imageFile)
                                : (imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : null),
                          ),
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
                  child: Obx(() {
                    final user = bottomController.userData.value;
                    final name = user?.messangerdetail?.name ??
                        user?.customerdetail?.fullName;
                    return Text(
                      controller.messangerDetail.value?.messangerdetail?.name ??
                          controller.customerDetail.value?.fullName ??
                          name ??
                          'Name',
                      style: themes.fontSize14_500,
                    );
                  }),
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
                      child: Obx(
                        () {
                          if (controller.isProfileLoading.value ==
                              Status.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (controller.isProfileLoading.value ==
                              Status.error) {
                            return const Center(child: Text('No Data Found!'));
                          } else if (controller.isProfileLoading.value ==
                              Status.success) {
                            return Column(
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
                                    // Obx(() {
                                    //   return controller.isEdit.value
                                    //       ? TextButton.icon(
                                    //           style: TextButton.styleFrom(
                                    //               foregroundColor:
                                    //                   themes.whiteColor,
                                    //               backgroundColor:
                                    //                   themes.darkCyanBlue),
                                    //           icon: Icon(
                                    //             Icons.save,
                                    //             color: themes.whiteColor,
                                    //           ),
                                    //           onPressed: () {
                                    //             controller.editProfile;
                                    //             controller.updateProfile();
                                    //           },
                                    //           label: Text(
                                    //             'Save',
                                    //             style: themes.fontSize14_500
                                    //                 .copyWith(
                                    //               fontSize: 16.sp,
                                    //             ),
                                    //           ))
                                    //       : TextButton.icon(
                                    //           icon: Icon(
                                    //             CupertinoIcons
                                    //                 .square_pencil_fill,
                                    //             color: themes.grayColor,
                                    //           ),
                                    //           onPressed: controller.editProfile,
                                    //           label: Text(
                                    //             'Edit',
                                    //             style: themes.fontSize14_500
                                    //                 .copyWith(
                                    //                     fontSize: 16.sp,
                                    //                     color:
                                    //                         themes.grayColor),
                                    //           ));
                                    // })
                                  ],
                                ),
                                Text(
                                  yourName,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                CommonTextfiled(
                                  hintTxt: 'Enter your name',
                                  isEnable: controller.isEdit.value,
                                  controller: controller.nameController,
                                ),
                                Text(
                                  user?.role == "messanger"
                                      ? 'Code'
                                      : 'Company Name',
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt: user?.role == "messanger"
                                        ? 'Enter code'
                                        : 'Company Name',
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.codeController,
                                  );
                                }),
                                if (user?.role != 'messanger')
                                  Column(
                                    spacing: 8.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Category',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt:
                                              user?.customerdetail?.category ??
                                                  'Category',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller: controller.cateController,
                                        );
                                      }),
                                    ],
                                  ),
                                Text(
                                  state,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt: user?.messangerdetail?.stateName ??
                                        user?.customerdetail?.stateName,
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.stateController,
                                  );
                                }),
                                Text(
                                  city,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt: user?.messangerdetail?.cityName ??
                                        user?.customerdetail?.cityName,
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.cityController,
                                  );
                                }),
                                Text(
                                  branch,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt:
                                        user?.messangerdetail?.branchName ??
                                            user?.customerdetail?.branchName,
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.branchController,
                                  );
                                }),
                                Text(
                                  'Address1',
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt:
                                        user?.customerdetail?.regAddress1 ??
                                            'Address1',
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.address1Controller,
                                  );
                                }),
                                Text(
                                  'Address2',
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt:
                                        user?.customerdetail?.regAddress2 ??
                                            'Address2',
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.address2Controller,
                                  );
                                }),
                                Text(
                                  'Pincode',
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt: user?.customerdetail?.pincode ??
                                        'Pincode',
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.cityController,
                                  );
                                }),
                                if (user?.role != 'customer')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8.h,
                                    children: [
                                      Text(
                                        'Route',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.messangerdetail
                                                  ?.routeCode ??
                                              'AXL- 033',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.routeController,
                                        );
                                      }),
                                    ],
                                  ),
                                Text(
                                  mobile,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    hintTxt: user?.messangerdetail?.phone ??
                                        user?.customerdetail?.mobileNo ??
                                        'Mobile No',
                                    controller: controller.phoneController,
                                  );
                                }),
                                Text(
                                  email,
                                  style: themes.fontSize14_500
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                                Obx(() {
                                  return CommonTextfiled(
                                    hintTxt: user?.messangerdetail?.email ??
                                        user?.customerdetail?.email ??
                                        email,
                                    isEnable: controller.isEdit.value &&
                                        user?.role == "messanger",
                                    controller: controller.emailController,
                                  );
                                }),
                                if (user?.role != 'customer')
                                  Column(
                                    spacing: 8.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vehicle No',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.messangerdetail
                                                  ?.vehicleNo ??
                                              '0555',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                    ],
                                  ),
                                if (user?.role == 'customer')
                                  Column(
                                    spacing: 12.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Business nature',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail
                                                  ?.natureBusiness ??
                                              '0555',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'fax No',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail?.faxNo,
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'Pan No',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt:
                                              user?.customerdetail?.panNo != ''
                                                  ? user?.customerdetail?.panNo
                                                  : 'Pan No',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'Gst No',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt:
                                              user?.customerdetail?.gstNo ??
                                                  'Gst No',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'AXLPL Insurance value',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail
                                                  ?.axlplInsuranceValue ??
                                              'AXLPL Insurance value',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'Third party insurance value',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail
                                                  ?.thirdPartyInsuranceValue ??
                                              'Third party insurance value',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'Third party policy No',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail
                                                  ?.thirdPartyPolicyNo ??
                                              'Third party policy No',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                      Text(
                                        'Third party expiry date',
                                        style: themes.fontSize14_500.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Obx(() {
                                        return CommonTextfiled(
                                          hintTxt: user?.customerdetail
                                                  ?.thirdPartyExpDate
                                                  ?.toIso8601String()
                                                  .split("T")[0] ??
                                              'Third party expiry date',
                                          isEnable: controller.isEdit.value &&
                                              user?.role == "messanger",
                                          controller:
                                              controller.vehicleController,
                                        );
                                      }),
                                    ],
                                  )
                              ],
                            );
                          } else {
                            return Center(child: Text('No Data Found'));
                          }
                        },
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
                // if (user?.role != 'messanger')
                //   Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                //     child: InkWell(
                //       onTap: () {
                //         showRatingDialog(context);
                //         // Get.toNamed(
                //         //   Routes.MYORDERS,
                //         // );
                //       },
                //       child: ListTile(
                //           tileColor: themes.whiteColor,
                //           dense: false,
                //           leading: CircleAvatar(
                //               backgroundColor: themes.blueGray,
                //               child: Image.asset(
                //                 orders,
                //                 width: 18.w,
                //               )),
                //           title: Text(myOrders),
                //           trailing: CircleAvatar(
                //             backgroundColor: themes.lightCream,
                //             // radius: 15,
                //             child: Icon(
                //               Icons.arrow_forward,
                //               size: 20.w,
                //             ),
                //           )),
                //     ),
                //   ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      showChangePasswordDialog();
                    },
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
                    onTap: () => commonDialog(
                      'Logout',
                      'Are you sure you want to Logout?',
                      'Logout',
                      'No',
                      () {
                        authController.logoutUser();
                      },
                    ),
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
