import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/consignment_controller.dart';

class ConsignmentView extends GetView<ConsignmentController> {
  const ConsignmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Consignment'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                spacing: 20.h,
                children: [
                  Row(
                    spacing: 10.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedContainer(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.isSelected.value == 0
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color: controller.isSelected.value == 0
                                      ? themes.whiteColor
                                      : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Add Consignment',
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color: controller.isSelected.value == 0
                                        ? themes.whiteColor
                                        : themes.grayColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedContainer(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.isSelected.value == 1
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color: controller.isSelected.value == 1
                                      ? themes.whiteColor
                                      : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Show Consignment',
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color: controller.isSelected.value == 1
                                        ? themes.whiteColor
                                        : themes.grayColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
             
                  controller.isSelected.value == 0
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: themes.whiteColor,
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dropdownText('Source Branch'),
                                commomDropdown(
                                    hint: 'Mumbai',
                                    selectedValue:
                                        controller.selectedSourceBranch,
                                    onChanged: (value) => controller
                                        .selectedSourceBranch.value = value!,
                                    items: controller.branches),
                                dropdownText('Destination Branch'),
                                commomDropdown(
                                    hint: 'Mumbai',
                                    selectedValue:
                                        controller.selectedSourceBranch,
                                    onChanged: (value) => controller
                                        .selectedSourceBranch.value = value!,
                                    items: controller.branches),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    dropdownText('Start Date'),
                                    dropdownText('End Date')
                                  ],
                                ),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CommomTextfiled(
                                        hintTxt:
                                            "${controller.selectedStartDate.value.toLocal()}"
                                                .split(" ")[0],
                                        isReadOnly: true,
                                        sufixIcon: InkWell(
                                            onTap: () =>
                                                showPicker(context, (value) {
                                                  controller.selectedStartDate
                                                      .value = value;
                                                }, []),
                                            child: Icon(
                                                CupertinoIcons.calendar_today)),
                                      ),
                                    ),
                                    Expanded(
                                      child: CommomTextfiled(
                                        hintTxt:
                                            "${controller.selectedEndDate.value.toLocal()}"
                                                .split(" ")[0],
                                        isReadOnly: true,
                                        sufixIcon: InkWell(
                                            onTap: () =>
                                                showPicker(context, (value) {
                                                  controller.selectedEndDate
                                                      .value = value;
                                                }, []),
                                            child: Icon(
                                                CupertinoIcons.calendar_today)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CommonButton(
                                  title: 'Load Shipment',
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        )
                      : Text(controller.showConsiment.value)
                ],
              ),
            ),
          ),
        ));
  }
}
