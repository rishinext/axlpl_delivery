import 'dart:developer';

import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/stepper_widget.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsView
    extends GetView<RunningDeliveryDetailsController> {
  const RunningDeliveryDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    StepperType type = StepperType.horizontal;
    return CommonScaffold(
        appBar: commonAppbar('Running Delivery Detail'),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: themes.whiteColor,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                backgroundColor: themes.blueGray,
                                child: Image.asset(shopingIcon, width: 18.w),
                              ),
                            ),
                            Text(
                              'Order No: 1203245',
                              style: themes.fontSize14_500,
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  color: themes.blueGray,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: themes.darkCyanBlue),
                                    ),
                                    Text(
                                      ' On Delivery',
                                      style: themes.fontSize14_500
                                          .copyWith(color: themes.darkCyanBlue),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipper Name',
                                    style: themes.fontSize14_500
                                        .copyWith(color: themes.grayColor),
                                  ),
                                  Text('Mr. Biju Dahal',
                                      style: themes.fontSize14_500),
                                  Text(
                                    'From',
                                    style: themes.fontSize14_500
                                        .copyWith(color: themes.grayColor),
                                  ),
                                  Text('Lorem Ipsum is simply\ndummy text ',
                                      style: themes.fontSize14_500),
                                  Text('Shipping Type',
                                      style: themes.fontSize14_500
                                          .copyWith(color: themes.grayColor)),
                                  Text('Standrd', style: themes.fontSize14_500),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipper Name',
                                    style: themes.fontSize14_500
                                        .copyWith(color: themes.grayColor),
                                  ),
                                  Text('Mr. Biju Dahal',
                                      style: themes.fontSize14_500),
                                  Text(
                                    'To',
                                    style: themes.fontSize14_500
                                        .copyWith(color: themes.grayColor),
                                  ),
                                  Text('Lorem Ipsum is simply\ndummy text ',
                                      style: themes.fontSize14_500),
                                  Text('Wight',
                                      style: themes.fontSize14_500
                                          .copyWith(color: themes.grayColor)),
                                  Text('1.3kg', style: themes.fontSize14_500),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: themes.whiteColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Obx(() => EnhanceStepper(
                            physics: ClampingScrollPhysics(),
                            stepIconSize: 40, // Adjust size if needed
                            stepIconBuilder: (stepIndex, stepState) =>
                                Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: stepState == StepState.complete
                                    ? themes
                                        .blueGray // ✅ Change completed step color
                                    : Colors.grey[
                                        300], // ✅ Change pending step color
                              ),
                              padding: EdgeInsets.all(
                                  10), // Adjust spacing inside circle
                              child: Icon(
                                Icons.gps_fixed,
                                color: themes
                                    .darkCyanBlue, // ✅ Ensure icon contrasts with background
                                size: 20,
                              ),
                            ),
                            type: StepperType.vertical,
                            currentStep: controller.currentStep.value,
                            onStepTapped: (index) =>
                                controller.currentStep.value = index,
                            steps: controller.stepsData.map((step) {
                              return EnhanceStep(
                                isActive: true,
                                state: StepState.complete,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        step["title"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      step["date"],
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      step["subtitle"],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    if (step["hasDriver"] == true) ...[
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                AssetImage(step["driverImage"]),
                                            radius: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Driver",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                step["driverName"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 5.h),
                                            decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  phoneIcon,
                                                  width: 15.w,
                                                ),
                                                SizedBox(width: 5),
                                                Text(step["phone"],
                                                    style: themes.fontSize14_500
                                                        .copyWith(
                                                            fontSize: 14.sp,
                                                            color: themes
                                                                .darkCyanBlue)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                            controlsBuilder: (context, details) =>
                                SizedBox(), // Hide buttons
                          )

                      // Hide buttons
                      ),
                ),
              ],
            ),
          ),
        ));
  }
}
