import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/utils.dart';
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
          child: Column(
            spacing: 20.h,
            children: [
              Row(
                spacing: 10.w,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => GestureDetector(
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
                  ),
                  Expanded(
                    child: Obx(
                      () => GestureDetector(
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
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: themes.whiteColor,
                    borderRadius: BorderRadius.circular(4.r)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dropdownText('Source Branch'),
                      commomDropdown(
                          hint: 'Select Source Branch ',
                          selectedValue: 0,
                          onChanged: (p0) {},
                          items: [''])
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
