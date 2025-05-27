import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/running_delivery_details_controller.dart';

class RunningDeliveryDetailsView
    extends GetView<RunningDeliveryDetailsController> {
  // final RunningPickUp? runningPickUp;
  RunningDeliveryDetailsView({
    super.key,
    // this.runningPickUp,
  });
  @override
  Widget build(BuildContext context) {
    StepperType type = StepperType.horizontal;
    final shipmentId = Get.parameters['shipmentID'];
    final status = Get.parameters['status'];

    return CommonScaffold(
      appBar: commonAppbar('Running Delivery Detail'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(child: Obx(
          () {
            final senderData = controller.senderData;
            final receiverData = controller.receiverData;

            final trackingStatus = controller.trackingStatus;

            String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(
              trackingStatus[0].dateTime,
            );

            if (controller.isTrackingLoading.value == Status.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (controller.isTrackingLoading.value == Status.error) {
              return Center(
                child: Text('No Tracking Data Found'),
              );
            } else if (controller.isTrackingLoading.value == Status.success) {
              return Column(
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
                              CircleAvatar(
                                backgroundColor: themes.blueGray,
                                child: Image.asset(shopingIcon, width: 18.w),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  shipmentId.toString(),
                                  overflow: TextOverflow.fade,
                                  style: themes.fontSize14_500,
                                ),
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
                                        " ${status.toString()}",
                                        style: themes.fontSize14_500.copyWith(
                                            color: themes.darkCyanBlue),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Sender Name',
                                        style: themes.fontSize14_500
                                            .copyWith(color: themes.grayColor)),
                                    SizedBox(height: 4),
                                    Text(
                                        senderData.isNotEmpty
                                            ? senderData[0].senderName ??
                                                'No sender name'
                                            : 'No sender name',
                                        style: themes.fontSize14_500),
                                    SizedBox(height: 16),
                                    Text('From',
                                        style: themes.fontSize14_500
                                            .copyWith(color: themes.grayColor)),
                                    SizedBox(height: 4),
                                    Text(
                                        senderData.isNotEmpty
                                            ? senderData[0].address1 ?? ''
                                            : '',
                                        style: themes.fontSize14_500),
                                  ],
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Shipper Name',
                                        style: themes.fontSize14_500
                                            .copyWith(color: themes.grayColor)),
                                    SizedBox(height: 4),
                                    Text(
                                        receiverData.isNotEmpty
                                            ? receiverData[0].receiverName ??
                                                'No receiver name'
                                            : 'No receiver name',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: themes.fontSize14_500),
                                    SizedBox(height: 16),
                                    Text('To',
                                        style: themes.fontSize14_500
                                            .copyWith(color: themes.grayColor)),
                                    SizedBox(height: 4),
                                    Text(
                                      receiverData.isNotEmpty
                                          ? receiverData[0].address1 ?? ''
                                          : '',
                                      style: themes.fontSize14_500,
                                    ),
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
                      child: EnhanceStepper(
                        physics: ClampingScrollPhysics(),
                        stepIconSize: 40, // Adjust size if needed
                        stepIconBuilder: (stepIndex, stepState) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: stepState == StepState.complete
                                ? themes
                                    .blueGray // ✅ Change completed step color
                                : Colors
                                    .grey[300], // ✅ Change pending step color
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
                        steps: controller.trackingStatus.map((step) {
                          return EnhanceStep(
                            isActive: true,
                            state: StepState.complete,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    step.status,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trackingStatus[0].status,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                // if (step["hasDriver"] == true) ...[
                                //   SizedBox(height: 8),
                                //   Row(
                                //     children: [
                                //       CircleAvatar(
                                //         backgroundImage:
                                //             AssetImage(step["driverImage"]),
                                //         radius: 20,
                                //       ),
                                //       SizedBox(width: 8),
                                //       Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             "Driver",
                                //             style: TextStyle(color: Colors.grey),
                                //           ),
                                //           Text(
                                //             step["driverName"],
                                //             style: TextStyle(
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ],
                                //       ),
                                //       Spacer(),
                                //       InkWell(
                                //         onTap: () {
                                //           // controller.makingPhoneCall();
                                //         },
                                //         child: Container(
                                //           padding: EdgeInsets.symmetric(
                                //               horizontal: 12.w, vertical: 5.h),
                                //           decoration: BoxDecoration(
                                //             color: Colors.blue[100],
                                //             borderRadius:
                                //                 BorderRadius.circular(20),
                                //           ),
                                //           child: Row(
                                //             children: [
                                //               Image.asset(
                                //                 phoneIcon,
                                //                 width: 15.w,
                                //               ),
                                //               SizedBox(width: 5),
                                //               Text(step["phone"],
                                //                   style: themes.fontSize14_500
                                //                       .copyWith(
                                //                           fontSize: 14.sp,
                                //                           color: themes
                                //                               .darkCyanBlue)),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ],
                              ],
                            ),
                          );
                        }).toList(),
                        controlsBuilder: (context, details) =>
                            SizedBox(), // Hide buttons
                      )

                      // Hide buttons
                      ),
                ],
              );
            } else {
              return Center(
                child: Text('No Track Data Found!'),
              );
            }
          },
        )),
      ),
    );
  }
}
