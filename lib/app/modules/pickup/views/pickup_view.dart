import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';

import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/pickup_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_widget.dart';
import 'package:axlpl_delivery/common_widget/transfer_dialog.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pickup_controller.dart';

class PickupView extends GetView<PickupController> {
  const PickupView({super.key});
  @override
  Widget build(BuildContext context) {
    final pickupController = Get.put(PickupController());
    final historyController = Get.put(HistoryController());
    final runningController = Get.put(RunningDeliveryDetailsController());

    return CommonScaffold(
      appBar: commonAppbar('Pickup'),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.h,
              children: [
                ContainerTextfiled(
                  hintText: '   Search Here',
                  // controller: pickupController.pincodeController,
                  onChanged: (value) {
                    pickupController.filterByQuery(value!);
                    return null;
                  },
                  // suffixIcon: IconButton(
                  //   onPressed: () {
                  //     pickupController.filterByQuery(
                  //       pickupController.pincodeController.text,
                  //     );
                  //   },
                  //   icon: Icon(
                  //     CupertinoIcons.clear,
                  //     color: themes.grayColor,
                  //   ),
                  // ),
                ),
                Obx(
                  () => Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            pickupController.selectedContainer(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: pickupController.isSelected.value == 0
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color: pickupController.isSelected.value == 0
                                      ? themes.whiteColor
                                      : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Pickup",
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color:
                                        pickupController.isSelected.value == 0
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
                            pickupController.selectedContainer(1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: pickupController.isSelected.value == 1
                                    ? themes.darkCyanBlue
                                    : themes.whiteColor,
                                borderRadius: BorderRadius.circular(
                                  15.r,
                                ),
                                border: Border.all(
                                  color: pickupController.isSelected.value == 1
                                      ? themes.whiteColor
                                      : themes.grayColor,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Picked-up',
                                textAlign: TextAlign.center,
                                style: themes.fontSize14_500.copyWith(
                                    color:
                                        pickupController.isSelected.value == 1
                                            ? themes.whiteColor
                                            : themes.grayColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'Recent Selected Pin code',
                //   style: themes.fontSize14_500,
                // ),
                pickupController.isSelected.value == 0
                    ? Obx(
                        () {
                          if (pickupController.isPickupLoading.value ==
                              Status.loading) {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          } else if (pickupController.isPickupLoading.value ==
                                  Status.error ||
                              pickupController.filteredPickupList.isEmpty) {
                            log(Status.error.toString());
                            return Center(
                              child: Text(
                                'No Pickup Data Found!',
                                style: themes.fontSize14_500,
                              ),
                            );
                          } else if (pickupController.isPickupLoading.value ==
                              Status.success) {
                            return SizedBox(
                              height: 500.h,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: pickupController.pickupList.length,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 0.h,
                                ),
                                itemBuilder: (context, index) {
                                  var data = pickupController.pickupList[index];
                                  return Container(
                                      margin: EdgeInsets.all(8.w),
                                      padding: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                        color: themes.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4.r,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            Routes.RUNNING_DELIVERY_DETAILS,
                                            parameters: {
                                              'shipmentID':
                                                  data.shipmentId.toString(),
                                              'status': data.status.toString(),
                                            },
                                          );
                                        },
                                        child: PickupWidget(
                                          companyName:
                                              data.companyName.toString(),
                                          date: data.date.toString(),
                                          status: data.status.toString(),
                                          messangerName:
                                              data.messangerName.toString(),
                                          address: data.address1.toString(),
                                          shipmentID:
                                              data.shipmentId.toString(),
                                          cityName: data.cityName.toString(),
                                          mobile: data.mobile.toString(),
                                          statusColor:
                                              data.status == 'Picked up'
                                                  ? themes.greenColor
                                                  : themes.redColor,
                                          statusDotColor: data.axlpInsurance ==
                                                  'axlpl_insurance'
                                              ? themes.greenColor
                                              : themes.redColor,
                                          showPickupBtn: true,
                                          showTrasferBtn: true,
                                          showDivider: true,
                                          openDialerTap: () {
                                            runningController.makingPhoneCall(
                                                data.mobile.toString());
                                          },
                                          openMapTap: () {
                                            pickupController.openMapWithAddress(
                                                data.companyName.toString(),
                                                data.address1.toString(),
                                                data.pincode.toString());
                                          },
                                          pickUpTap: () {
                                            showPickDialog(
                                                data.shipmentId.toString(),
                                                data.date.toString());
                                          },
                                          trasferTap: () {
                                            showTransferDialog(
                                              () {
                                                pickupController
                                                    .transferShipment(
                                                        data.shipmentId,
                                                        data.id);
                                              },
                                            );
                                          },
                                        ),
                                      ));
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No Pickup Found!',
                                style: themes.fontSize18_600,
                              ),
                            );
                          }
                        },
                      )
                    : Obx(() {
                        if (historyController.isPickedup.value ==
                            Status.loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (historyController
                                .pickUpHistoryList.isEmpty ||
                            historyController.isPickedup.value ==
                                Status.error) {
                          return Center(
                              child: Text(
                            'No Pickup History Data Found!',
                            style: themes.fontReboto16_600,
                          ));
                        } else if (historyController.isPickedup.value ==
                            Status.success) {
                          return SizedBox(
                            height: 500.h,
                            child: ListView.separated(
                              itemCount:
                                  historyController.pickUpHistoryList.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(),
                              itemBuilder: (context, index) {
                                var data =
                                    historyController.pickUpHistoryList[index];
                                return InkWell(
                                  onTap: () {
                                    runningController.fetchTrackingData(
                                        data.shipmentId.toString());
                                    Get.toNamed(
                                      Routes.RUNNING_DELIVERY_DETAILS,
                                      parameters: {
                                        'shipmentID':
                                            data.shipmentId.toString(),
                                        'status': data.status.toString(),
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8.w),
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: themes.whiteColor,
                                      borderRadius: BorderRadius.circular(15.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4.r,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: PickupWidget(
                                      paymentType: data.paymentMode,
                                      companyName: data.companyName.toString(),
                                      date: data.date.toString(),
                                      status: data.status.toString(),
                                      messangerName:
                                          data.messangerName.toString(),
                                      address: data.address1.toString(),
                                      shipmentID: data.shipmentId.toString(),
                                      cityName: data.cityName.toString(),
                                      mobile: data.mobile.toString(),
                                      statusColor: data.status == 'Picked up'
                                          ? themes.greenColor
                                          : themes.redColor,
                                      statusDotColor: data.status == 'Picked up'
                                          ? themes.greenColor
                                          : themes.redColor,
                                      showPickupBtn: false,
                                      showTrasferBtn: false,
                                      showDivider: false,
                                      openMapTap: () {
                                        pickupController.openMapWithAddress(
                                            data.companyName.toString(),
                                            data.address1.toString(),
                                            data.pincode.toString());
                                      },
                                      openDialerTap: () {
                                        runningController.makingPhoneCall(
                                            data.mobile.toString());
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
