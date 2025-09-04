import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/nature_business_model.dart';
import 'package:axlpl_delivery/app/data/models/register_cate_model.dart';
import 'package:axlpl_delivery/app/modules/register/views/customer_register1_view.dart';
import 'package:axlpl_delivery/app/modules/register/views/customer_register2_view.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/common_widget/image_picker_widget.dart';
import 'package:axlpl_delivery/common_widget/paginated_dropdown.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      return DateFormat('dd/MM/yyyy').format(date); // Format the date
    }

    Utils utils = Utils();
    return CommonScaffold(
        appBar: commonAppbar(
          'Customer Register',
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: themes.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 15.h),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10.h,
                    children: [
                      /*
                      Expanded(
                        child: PageView(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          controller: controller.pageController,
                          onPageChanged: (value) => controller.currentPage.value = value,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            Form(
                              key: controller.formKeys[0],
                              child: CustomerRegister1View(),
                            ),
                            Form(
                              key: controller.formKeys[1],
                              child: CustomerRegister2View(),
                            ),
                          ],
                        ),
                      ),*/
                      CommonTextfiled(
                        hintTxt: 'Company Name',
                        controller: controller.companyNameController,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Full Name',
                        controller: controller.fullNameController,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      Obx(() => PaginatedDropdown<RegisterCategoryList>(
                          isSearchable: false,
                          hint: 'Select Category',
                          selectedValue: controller.selectedCategory.value,
                          items: controller.registerCategoryList,
                          itemLabel: (category) => category.name ?? 'Unknown',
                          itemValue: (category) => category.value,
                          isLoading: controller.isLoadingCate.value,
                          onChanged: (RegisterCategoryList? category) {
                            controller.selectedCategory.value = category;
                          })),
                      Obx(() => PaginatedDropdown<NatureOfBusiness>(
                          isSearchable: false,
                          hint: 'Select Nature of Business',
                          selectedValue:
                              controller.selectedNatureBusiness.value,
                          items: controller.registerNatureBusinessList,
                          itemLabel: (nature) => nature.name ?? 'Unknown',
                          itemValue: (nature) => nature.value,
                          isLoading: controller.isNatureBusinessLoading.value,
                          onChanged: (NatureOfBusiness? nature) {
                            controller.selectedNatureBusiness.value = nature;
                          })),
                      CommonTextfiled(
                        hintTxt: 'Address',
                        controller: controller.address1Controller,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Address 2',
                        controller: controller.address2Controller,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: zip,
                        controller: controller.zipController,
                        textInputAction: TextInputAction.next,
                        validator: utils.validateIndianZipcode,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value?.length == 6) {
                            controller.fetchPincodeDetails(value!);
                            controller.fetchAera(value);
                          } else {
                            // Optional: clear state/city if length < 6 again
                            controller.pincodeDetailsData.value = null;
                          }
                          return null;
                        },
                      ),

                      Obx(() {
                        final isLoading = controller.isLoadingPincode.value;
                        final data = controller.pincodeDetailsData.value;
                        final error = controller.errorMessage.value;

                        if (isLoading) {
                          Center(child: CircularProgressIndicator.adaptive());
                        }
                        log("state id : => ${data?.stateId.toString() ?? 'N/A'}");
                        return CommonTextfiled(
                          isEnable: false,
                          hintTxt: data?.stateName ??
                              (error.isNotEmpty ? error : 'State'),
                          textInputAction: TextInputAction.next,
                          controller: controller.stateController,
                        );
                      }),

                      //new sender address
                      Obx(() {
                        final isLoading = controller.isLoadingPincode.value;
                        final data = controller.pincodeDetailsData.value;
                        final error = controller.errorMessage.value;
                        log(data?.cityId.toString() ?? 'N/A');

                        if (isLoading) {
                          Center(child: CircularProgressIndicator.adaptive());
                        }
                        controller.selectedSenderStateId.value =
                            int.tryParse(data?.stateId ?? '0') ?? 0;
                        controller.selectedSenderCityId.value =
                            int.tryParse(data?.cityId ?? '0') ?? 0;
                        controller.selectedSenderAreaId.value = int.tryParse(
                              data?.areaId ?? '0',
                            ) ??
                            0;
                        return CommonTextfiled(
                          isEnable: false,
                          hintTxt: data?.cityName ??
                              (error.isNotEmpty ? error : 'City'),
                          textInputAction: TextInputAction.next,
                          controller: controller.cityController,
                        );
                      }),

                      /*   Obx(() {
                        return CommonDropdown<AreaList>(
                          hint: 'Select Area',
                          selectedValue: controller.selectedSenderArea.value,
                          isLoading: controller.isLoadingArea.value,
                          items: controller.areaList,
                          itemLabel: (c) => c.name ?? 'Unknown',
                          itemValue: (c) => c.id.toString(),
                          onChanged: (val) =>
                              controller.selectedSenderArea.value = val,
                        );
                      }),*/
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            // Check if zipcode length is not 6
                            if (controller.zipController.text.length != 6) {
                              Get.snackbar(
                                'Enter Zipcode',
                                'Please enter valid 6-digit zipcode',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: themes.redColor,
                                colorText: themes.whiteColor,
                              );
                            }
                            // If zipcode length is 6, the dropdown will be interactive (no AbsorbPointer)
                          },
                          child: AbsorbPointer(
                            // Absorb pointer events only when zipcode length is not 6
                            absorbing:
                                controller.zipController.text.length != 6,
                            child: PaginatedDropdown<AreaList>(
                              isSearchable: false,
                              hint: 'Select Area',

                              selectedValue:
                                  controller.selectedSenderArea.value,
                              items: controller.zipController.text.length == 6
                                  ? controller.areaList
                                  : <AreaList>[], // Empty list when zipcode is invalid
                              itemLabel: (area) => area.name ?? 'Unknown',
                              itemValue: (area) => area.id.toString(),
                              isLoading: controller.isLoadingArea.value,
                              onChanged: (AreaList? area) {
                                if (controller.zipController.text.length == 6) {
                                  controller.selectedSenderArea.value = area;
                                  // You might want to fetch area data here
                                  // controller.fetchArea(controller.zipController.text);
                                }
                              },
                            ),
                          ),
                        );
                      }),

                      CommonTextfiled(
                        hintTxt: 'Mobile No',
                        controller: controller.mobileController,
                        validator: utils.validatePhone,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Telephone No',
                        controller: controller.telePhoneController,
                        validator: utils.validatePhone,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Fax No',
                        controller: controller.faxController,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Email',
                        controller: controller.emailController,
                        validator: utils.validateEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Password',
                        controller: controller.passwordController,
                        validator: utils.validatePassword,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Pan No',
                        controller: controller.panController,
                        validator: utils.validatePan,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Gst No',
                        controller: controller.gstController,
                        validator: utils.validateGST,
                        textInputAction: TextInputAction.next,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Third Party Insurance Value',
                        controller: controller.insuranceController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      CommonTextfiled(
                        hintTxt: 'Third Party Policy No',
                        controller: controller.thirdPartyPolicyController,
                        validator: utils.validateText,
                        textInputAction: TextInputAction.next,
                      ),
                      Obx(
                        () => CommonTextfiled(
                          isReadOnly: true,
                          controller: controller.thirdDateController,
                          sufixIcon: IconButton(
                              onPressed: () async {
                                await controller.pickDate(
                                    context, controller.date);
                              },
                              icon: Icon(CupertinoIcons.calendar_today)),
                          hintTxt: formatDate(controller.date.value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [8, 4],
                          radius: Radius.circular(10.r),
                          padding: EdgeInsets.all(2),
                          color: themes.blueColor,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: themes.blueGray,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                                padding: const EdgeInsets.all(38.0).r,
                                child: Obx(
                                  () {
                                    if (controller.panFile.value == null) {
                                      return InkWell(
                                        onTap: () {
                                          pickImage(ImageSource.gallery,
                                              controller.panFile);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              uploadIcon,
                                              width: 40.w,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              'Upload your Pancard',
                                              style: themes.fontSize14_500,
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Stack(
                                          fit: StackFit.loose,
                                          alignment: Alignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: Image.file(
                                                // width: 60.w,
                                                height: 150.h,
                                                File(
                                                  controller
                                                      .panFile.value!.path,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 160,
                                              child: IconButton(
                                                iconSize: 30,
                                                onPressed: () {
                                                  controller.panFile.value =
                                                      null;
                                                },
                                                icon: Icon(Icons.cancel),
                                              ),
                                            ),
                                          ]);
                                    }
                                  },
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [8, 4],
                          radius: Radius.circular(10.r),
                          padding: EdgeInsets.all(2),
                          color: themes.blueColor,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: themes.blueGray,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                                padding: const EdgeInsets.all(38.0).r,
                                child: Obx(
                                  () {
                                    if (controller.gstFile.value == null) {
                                      return InkWell(
                                        onTap: () {
                                          pickImage(ImageSource.gallery,
                                              controller.gstFile);
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              uploadIcon,
                                              width: 40.w,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              'Upload your GST Certificate',
                                              style: themes.fontSize14_500,
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Stack(
                                          fit: StackFit.loose,
                                          alignment: Alignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: Image.file(
                                                // width: 60.w,
                                                height: 150.h,
                                                File(
                                                  controller
                                                      .gstFile.value!.path,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 160,
                                              child: IconButton(
                                                iconSize: 30,
                                                onPressed: () {
                                                  controller.gstFile.value =
                                                      null;
                                                },
                                                icon: Icon(Icons.cancel),
                                              ),
                                            ),
                                          ]);
                                    }
                                  },
                                )),
                          ),
                        ),
                      ),
                      CommonButton(
                          title: 'Register',
                          isLoading: controller.isRegistered.value,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (controller.formKey.currentState?.validate() ==
                                true) {
                              controller.register();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
