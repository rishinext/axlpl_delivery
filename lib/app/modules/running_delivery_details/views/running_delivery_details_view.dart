import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsView
    extends GetView<RunningDeliveryDetailsController> {
  const RunningDeliveryDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Running Delivery Detail'),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EasyStepper(
                      alignment: Alignment.topLeft,
                      direction: Axis.vertical,
                      activeStep: controller.activeStep.value,
                      stepShape: StepShape.circle,
                      stepBorderRadius: 15,
                      borderThickness: 2,
                      stepRadius: 18,
                      finishedStepBorderColor: Colors.blue,
                      finishedStepTextColor: Colors.black,
                      finishedStepBackgroundColor: Colors.blue,
                      activeStepBorderColor: Colors.blue,
                      activeStepTextColor: Colors.black,
                      activeStepBackgroundColor: Colors.blue,
                      unreachedStepBorderColor: Colors.grey,
                      unreachedStepTextColor: Colors.grey,
                      unreachedStepBackgroundColor: Colors.white,
                      showLoadingAnimation: false,
                      steps:
                          List.generate(controller.stepTitles.length, (index) {
                        return EasyStep(
                          customStep: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Stepper Icon
                              Container(
                                width: 36, // Adjust width as needed
                                height: 36, // Adjust height as needed
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: index == controller.activeStep.value
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                child: Icon(
                                  index == controller.activeStep.value
                                      ? Icons.location_on
                                      : Icons.circle,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              SizedBox(
                                  width: 16), // Spacing between icon and text
                              // Step Details (Title and Date)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.stepTitles[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            index == controller.activeStep.value
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        color:
                                            index == controller.activeStep.value
                                                ? Colors.blue
                                                : Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      controller.stepDates[index],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      onStepReached: (index) =>
                          controller.activeStep.value = index,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
