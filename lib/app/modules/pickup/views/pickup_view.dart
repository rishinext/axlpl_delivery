import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/messnager_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/views/running_delivery_details_view.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';

import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/otp_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_dialog.dart';
import 'package:axlpl_delivery/common_widget/pickup_widget.dart';
import 'package:axlpl_delivery/common_widget/yes_no_dialog.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
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
                // ContainerTextfiled(
                //   hintText: '   Search Here',
                //   // controller: pickupController.pincodeController,
                //   onChanged: (value) {
                //     pickupController.filterByQuery(value!);
                //     return null;
                //   },
                // ),
                ContainerTextfiled(
                  controller: pickupController.pincodeController,
                  hintText: 'Search Here',
                  onChanged: (value) {
                    pickupController.filterByQuery(value!);
                    return null;
                  },
                  suffixIcon: Icon(CupertinoIcons.search),
                  prefixIcon: InkWell(
                    onTap: () async {
                      var scannedValue =
                          await Utils().scanAndPlaySound(context);
                      if (scannedValue != null && scannedValue != '-1') {
                        pickupController.pincodeController.text = scannedValue;
                        Get.dialog(
                          const Center(
                              child: CircularProgressIndicator.adaptive()),
                          barrierDismissible: false,
                        );

                        await runningController.fetchTrackingData(scannedValue);
                        Get.back(); // Close the dialog
                        Get.toNamed(
                          Routes.RUNNING_DELIVERY_DETAILS,
                          arguments: {
                            'shipmentID': scannedValue,
                            // 'status': data.status.toString(),
                            // 'invoicePath': data.invoicePath,
                            // 'invoicePhoto': data.invoiceFile,
                            // 'paymentMode': data.paymentMode,
                            // 'date': data.date,
                            // 'cashAmt': data.totalCharges
                          },
                        );
                      }
                    },
                    child: Icon(CupertinoIcons.qrcode_viewfinder),
                  ),
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
                            return RefreshIndicator.adaptive(
                              onRefresh: () => pickupController.getPickupData(),
                              child: SizedBox(
                                height: 500.h,
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: pickupController.pickupList.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 0.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    var pickupData =
                                        pickupController.pickupList[index];
                                    final userId =
                                        pickupController.currentUserId.value;
                                    final enableTransfer =
                                        pickupData.messangerId.toString() ==
                                            userId;

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
                                      child: PickupWidget(
                                        isShowPaymentType: false,
                                        pickupTxt: 'Pickup',
                                        onTap: () {
                                          runningController.fetchTrackingData(
                                              pickupData.shipmentId.toString());
                                          Get.to(
                                            RunningDeliveryDetailsView(
                                              isShowInvoice: true,
                                              isShowTransfer: true,
                                            ),
                                            arguments: {
                                              'messangerId': pickupData
                                                  .messangerId
                                                  .toString(),
                                              'shipmentID': pickupData
                                                  .shipmentId
                                                  .toString(),
                                              'status':
                                                  pickupData.status.toString(),
                                              'invoicePath':
                                                  pickupData.invoicePath,
                                              'invoicePhoto':
                                                  pickupData.invoiceFile,
                                              'paymentMode':
                                                  pickupData.paymentMode,
                                              'date': pickupData.date,
                                              'cashAmt': pickupData.totalCharges
                                            },
                                          );
                                        },
                                        companyName:
                                            pickupData.companyName.toString(),
                                        date: pickupData.date.toString(),
                                        status: pickupData.status.toString(),
                                        messangerName:
                                            pickupData.messangerName.toString(),
                                        address: pickupData.address1.toString(),
                                        shipmentID:
                                            pickupData.shipmentId.toString(),
                                        cityName:
                                            pickupData.cityName.toString(),
                                        mobile: pickupData.mobile.toString(),
                                        paymentType: pickupData.paymentMode,
                                        statusColor:
                                            pickupData.status == 'Picked up'
                                                ? themes.greenColor
                                                : themes.redColor,
                                        statusDotColor:
                                            pickupData.axlplInsurance ==
                                                    'axlpl_insurance'
                                                ? themes.greenColor
                                                : themes.redColor,
                                        showPickupBtn: true,
                                        showTrasferBtn: true,
                                        showDivider: true,
                                        openDialerTap: () {
                                          runningController.makingPhoneCall(
                                              pickupData.mobile.toString());
                                        },
                                        openMapTap: () {
                                          pickupController.openMapWithAddress(
                                              pickupData.companyName.toString(),
                                              pickupData.address1.toString(),
                                              pickupData.pincode.toString());
                                        },
                                        pickUpTap: () async {
                                          // Set the amountController to the pickup's totalCharges before showing dialog
                                          pickupController.amountController =
                                              pickupController
                                                  .getAmountController(
                                                      pickupData.shipmentId
                                                          .toString());
                                          pickupController.amountController
                                              .text = pickupData.totalCharges
                                                  ?.toString() ??
                                              '';
                                          final chequeController =
                                              pickupController
                                                  .getChequeController(
                                                      pickupData.shipmentId
                                                          .toString());
                                          final otpController =
                                              pickupController.getOtpController(
                                                  pickupData.shipmentId
                                                      .toString());
                                          final selectedSubPaymentMode =
                                              pickupController
                                                  .getSelectedSubPaymentMode(
                                                      pickupData.shipmentId
                                                          .toString());
                                          if (pickupData.paymentMode !=
                                              'topay') {
                                            showOtpDialog(
                                              () async {
                                                pickupController
                                                        .amountController =
                                                    pickupController
                                                        .getAmountController(
                                                            pickupData
                                                                .shipmentId
                                                                .toString());
                                                pickupController
                                                        .amountController.text =
                                                    pickupData.totalCharges
                                                            ?.toString() ??
                                                        '';
                                                final otpController =
                                                    pickupController
                                                        .getOtpController(
                                                            pickupData
                                                                .shipmentId
                                                                .toString());
                                                final selectedSubPaymentMode =
                                                    pickupController
                                                        .getSelectedSubPaymentMode(
                                                            pickupData
                                                                .shipmentId
                                                                .toString());
                                                pickupController.uploadPickup(
                                                    pickupData.shipmentId,
                                                    'Picked up',
                                                    pickupData.date,
                                                    pickupController
                                                        .amountController.text,
                                                    pickupData.paymentMode,
                                                    0,
                                                    otpController.text,
                                                    chequeNumber: '0');
                                                Get.back();
                                              },
                                              () async {
                                                await pickupController.getOtp(
                                                    pickupData.shipmentId);
                                              },
                                              otpController,
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (_) => PickDialog(
                                                shipmentID:
                                                    pickupData.shipmentId,
                                                date: pickupData.date,
                                                amt: pickupData.totalCharges,
                                                dropdownHintTxt:
                                                    'Select Payment Mode',
                                                btnTxt: 'Pickup',
                                                amountController:
                                                    pickupController
                                                        .amountController,
                                                chequeNumberController:
                                                    chequeController,
                                                otpController: otpController,
                                                selectedSubPaymentMode:
                                                    selectedSubPaymentMode,
                                                onConfirmCallback: () {
                                                  pickupController.uploadPickup(
                                                    pickupData.shipmentId,
                                                    'Picked up',
                                                    pickupData.date,
                                                    pickupController
                                                        .amountController.text,
                                                    pickupData.paymentMode,
                                                    selectedSubPaymentMode
                                                        .value?.id,
                                                    otpController.text,
                                                    chequeNumber:
                                                        chequeController.text,
                                                  );
                                                },
                                                onSendOtpCallback: () async {
                                                  await pickupController.getOtp(
                                                      pickupData.shipmentId);
                                                },
                                              ),
                                            );
                                          }
                                        },
                                        transferBtnColor: enableTransfer
                                            ? themes.whiteColor
                                            : themes.lightWhite,
                                        transferTextColor: enableTransfer
                                            ? themes.darkCyanBlue
                                            : themes.grayColor,
                                        trasferTap: enableTransfer
                                            ? () async {
                                                // Load messengers first
                                                await pickupController
                                                    .getMessangerData();

                                                Get.defaultDialog(
                                                  title: "Messangers",
                                                  content: SizedBox(
                                                    width: Get.width * 0.8,
                                                    height: 200.h,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Messanger List',
                                                            style: themes
                                                                .fontSize14_500,
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Expanded(
                                                            child: Obx(() {
                                                              if (pickupController
                                                                      .isMessangerLoading
                                                                      .value ==
                                                                  Status
                                                                      .loading) {
                                                                return const Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              }
                                                              if (pickupController
                                                                  .messangerList
                                                                  .isEmpty) {
                                                                return const Center(
                                                                    child: Text(
                                                                        'No messengers available'));
                                                              }
                                                              return CommonDropdown<
                                                                  MessangerList>(
                                                                isSearchable:
                                                                    true,
                                                                hint:
                                                                    'Select Messanger',
                                                                selectedValue:
                                                                    pickupController
                                                                        .selectedMessenger
                                                                        .value,
                                                                isLoading:
                                                                    false,
                                                                items: pickupController
                                                                    .messangerList,
                                                                itemLabel: (c) =>
                                                                    c.name ??
                                                                    'Unknown',
                                                                itemValue: (c) => c
                                                                    .id
                                                                    .toString(),
                                                                onChanged:
                                                                    (val) {
                                                                  pickupController
                                                                      .selectedMessenger
                                                                      .value = val!;
                                                                },
                                                              );
                                                            }),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  radius: 10,
                                                  buttonColor:
                                                      themes.darkCyanBlue,
                                                  textConfirm: "Transfer",
                                                  textCancel: "Cancel",
                                                  cancelTextColor:
                                                      themes.darkCyanBlue,
                                                  confirmTextColor:
                                                      themes.whiteColor,
                                                  onConfirm: () {
                                                    final messengerId =
                                                        pickupController
                                                            .selectedMessenger
                                                            .value
                                                            .toString();
                                                    if (messengerId
                                                        .isNotEmpty) {
                                                      pickupController
                                                          .transferShipment(
                                                        pickupData.shipmentId,
                                                        messengerId, // Pass selected messenger ID
                                                      );
                                                      Get.back();
                                                    } else {
                                                      Get.snackbar(
                                                        'Error',
                                                        'Please select a messenger',
                                                        colorText:
                                                            themes.whiteColor,
                                                        backgroundColor:
                                                            themes.redColor,
                                                      );
                                                    }
                                                  },
                                                );
                                              }
                                            : null,
                                        transferBorderColor: enableTransfer
                                            ? themes.darkCyanBlue
                                            : themes.grayColor,
                                      ),
                                    );
                                  },
                                ),
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
                          return Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (historyController
                                .pickUpHistoryList.isEmpty ||
                            historyController.isPickedup.value ==
                                Status.error) {
                          return Center(
                              child: Text(
                            'No Picked-up Data Found!',
                            style: themes.fontSize14_500,
                          ));
                        } else if (historyController.isPickedup.value ==
                            Status.success) {
                          return SizedBox(
                            height: 500.h,
                            child: RefreshIndicator.adaptive(
                              onRefresh: () =>
                                  historyController.getPickupHistory(),
                              child: ListView.separated(
                                itemCount:
                                    historyController.pickUpHistoryList.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    SizedBox(),
                                itemBuilder: (context, index) {
                                  var pickedUpData = historyController
                                      .pickUpHistoryList[index];
                                  return Container(
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
                                      onTap: () {
                                        runningController.fetchTrackingData(
                                            pickedUpData.shipmentId.toString());
                                        Get.to(
                                          // Routes.RUNNING_DELIVERY_DETAILS,
                                          RunningDeliveryDetailsView(
                                            isShowInvoice: true,
                                            isShowTransfer: false,
                                          ),
                                          arguments: {
                                            'shipmentID': pickedUpData
                                                .shipmentId
                                                .toString(),
                                            'status':
                                                pickedUpData.status.toString(),
                                            'invoicePath':
                                                pickedUpData.invoicePath,
                                            'invoicePhoto':
                                                pickedUpData.invoiceFile,
                                          },
                                        );
                                      },
                                      paymentType: pickedUpData.paymentMode,
                                      companyName:
                                          pickedUpData.companyName.toString(),
                                      date: pickedUpData.date.toString(),
                                      status: pickedUpData.status.toString(),
                                      messangerName:
                                          pickedUpData.messangerName.toString(),
                                      address: pickedUpData.address1.toString(),
                                      shipmentID:
                                          pickedUpData.shipmentId.toString(),
                                      cityName:
                                          pickedUpData.cityName.toString(),
                                      mobile: pickedUpData.mobile.toString(),
                                      statusColor:
                                          pickedUpData.status == 'Picked up'
                                              ? themes.greenColor
                                              : themes.redColor,
                                      statusDotColor:
                                          pickedUpData.status == 'Picked up'
                                              ? themes.greenColor
                                              : themes.redColor,
                                      showPickupBtn: false,
                                      showTrasferBtn: false,
                                      showDivider: false,
                                      openMapTap: () {
                                        pickupController.openMapWithAddress(
                                            pickedUpData.companyName.toString(),
                                            pickedUpData.address1.toString(),
                                            pickedUpData.pincode.toString());
                                      },
                                      openDialerTap: () {
                                        runningController.makingPhoneCall(
                                            pickedUpData.mobile.toString());
                                      },
                                    ),
                                  );
                                },
                              ),
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
