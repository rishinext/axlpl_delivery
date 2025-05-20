import 'dart:developer';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/history/controllers/history_controller.dart';
import 'package:axlpl_delivery/app/modules/running_delivery_details/controllers/running_delivery_details_controller.dart';

import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
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
                    ? SizedBox(
                        height: 505.h,
                        child: Obx(
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
                              return ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 5.h,
                                ),
                                itemCount:
                                    pickupController.filteredPickupList.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = pickupController
                                      .filteredPickupList[index];
                                  final messangerID =
                                      pickupController.messangerList;
                                  return InkWell(
                                    onTap: () {
                                      runningController.fetchTrackingData(
                                          data.shipmentId.toString());
                                      Get.toNamed(
                                        Routes.RUNNING_DELIVERY_DETAILS,
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),

                                        tileColor: themes.whiteColor,
                                        dense: false,
                                        // leading: CircleAvatar(
                                        //   backgroundColor: themes.blueGray,
                                        //   child: Image.asset(
                                        //     gpsIcon,
                                        //     width: 18.w,
                                        //   ),
                                        // ),
                                        title: Text(
                                            "Company Name : ${data.companyName.toString()}"),
                                        subtitle: Column(
                                          spacing: 5,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Messanger Name : ${data.messangerName.toString()}"),
                                            Text(
                                                "Phone : ${data.mobile.toString()}"),
                                            Text(
                                                "Zipcode : ${data.pincode.toString()}"),
                                            Text(
                                                "Shipment ID : ${data.shipmentId.toString()}"),
                                            Text(
                                                "Sender Address : ${data.address1.toString()}"),
                                            Text(
                                              "Status : ${data.status.toString()}",
                                              style: themes.fontReboto16_600
                                                  .copyWith(
                                                color: themes.redColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          // height: 48, // ListTile's default height
                                          width: 48,
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton.outlined(
                                              onPressed: () {
                                                pickupController
                                                    .openMapWithAddress(
                                                        data.companyName
                                                            .toString(),
                                                        data.address1
                                                            .toString(),
                                                        data.pincode
                                                            .toString());
                                              },
                                              icon: Icon(
                                                Icons.gps_fixed,
                                                color: themes.darkCyanBlue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
                        ),
                      )
                    : Obx(() {
                        if (historyController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (historyController.pickUpHistoryList.isEmpty) {
                          return Center(
                              child: Text(
                            'No Pickup History Data Found!',
                            style: themes.fontReboto16_600,
                          ));
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5.h,
                          ),
                          itemCount: historyController.pickUpHistoryList.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var pickup =
                                historyController.pickUpHistoryList[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r)),
                                tileColor: themes.whiteColor,
                                dense: false,
                                // leading: CircleAvatar(
                                //   backgroundColor: themes.blueGray,
                                //   child: Image.asset(
                                //     truckBlueIcon,
                                //     width: 18.w,
                                //   ),
                                // ),
                                title: Text(
                                    "Company Name : ${pickup.companyName.toString()}"),
                                subtitle: Column(
                                  spacing: 5,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Messanger Name : ${pickup.messangerName.toString()}"),
                                    Text("Phone : ${pickup.mobile.toString()}"),
                                    Text(
                                        "Zipcode : ${pickup.pincode.toString()}"),
                                    Text(
                                        "Shipment ID : ${pickup.shipmentId.toString()}"),
                                    Text(
                                        "Sender Address : ${pickup.address1.toString()}"),
                                    Text(
                                      "Status : ${pickup.status.toString()}",
                                      style: themes.fontReboto16_600.copyWith(
                                        color: themes.greenColor,
                                      ),
                                    )
                                  ],
                                ),
                                trailing: SizedBox(
                                  // height: 48, // ListTile's default height
                                  width: 48,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton.outlined(
                                      onPressed: () {
                                        pickupController.openMapWithAddress(
                                            pickup.companyName.toString(),
                                            pickup.address1.toString(),
                                            pickup.pincode.toString());
                                      },
                                      icon: Icon(
                                        Icons.gps_fixed,
                                        color: themes.darkCyanBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
   // ExpansionTile(
                                      //   collapsedShape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(10.r)),
                                      //   shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(10.r)),
                                      //   collapsedBackgroundColor: themes.darkCyanBlue,
                                      //   backgroundColor: themes.darkCyanBlue,
                                      //   iconColor: themes.whiteColor,
                                      //   collapsedIconColor: themes.whiteColor,
                                      //   title: Column(
                                      //     spacing: 20,
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         "shipment ID: ${data.shipmentId.toString()}",
                                      //         style: themes.fontSize14_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //       Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.spaceBetween,
                                      //         children: [
                                      //           Text(
                                      //             "Pincode : ${data.pincode.toString()}",
                                      //             style: themes.fontSize14_400
                                      //                 .copyWith(color: themes.whiteColor),
                                      //           ),
                                      //           CircleAvatar(
                                      //             backgroundColor: themes.lightCream,
                                      //             // radius: 15,
                                      //             child: IconButton(
                                      //               onPressed: () {
                                      //                 pickupController.openMapWithAddress(
                                      //                     data.address1.toString());
                                      //               },
                                      //               icon: Icon(
                                      //                 Icons.location_on_outlined,
                                      //                 color: themes.darkCyanBlue,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   children: <Widget>[
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Date : ${data.date?.toIso8601String().split('T')[0]}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Mobile No : ${data.mobile.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Branch : ${data.mobile.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Area : ${data.areaName.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Pincode : ${data.pincode.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Address : ${data.address1.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //     ),
                                      //     ListTile(
                                      //       title: Text(
                                      //         "Status : ${data.status.toString()}",
                                      //         style: themes.fontSize16_400
                                      //             .copyWith(color: themes.whiteColor),
                                      //       ),
                                      //       trailing: IconButton(
                                      //         onPressed: () {},
                                      //         icon: Icon(
                                      //           Icons.edit,
                                      //           color: themes.whiteColor,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // );
                                       /*    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          PopupMenuButton<String>(
                                            icon: Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              pickupController
                                                  .selectedMessenger.value = value;
                                              Utils().logInfo(
                                                  "Selected Messenger: $value");
                                              pickupController.transferShipment(
                                                  data.shipmentId,
                                                  messangerID[index].id);
                                            },
                                            itemBuilder: (BuildContext context) {
                                              if (pickupController
                                                      .isMessangerLoading.value ==
                                                  Status.loading) {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'no_data',
                                                    child: Text('Loading..'),
                                                    enabled: false,
                                                  )
                                                ];
                                              } else if (pickupController
                                                      .messangerList.isEmpty &&
                                                  pickupController
                                                          .isMessangerLoading
                                                          .value ==
                                                      Status.error) {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'no_data',
                                                    child: Text('No Messengers'),
                                                    enabled: false,
                                                  )
                                                ];
                                              } else if (pickupController
                                                      .isMessangerLoading.value ==
                                                  Status.success) {
                                                return pickupController
                                                    .messangerList
                                                    .map((messenger) =>
                                                        PopupMenuItem<String>(
                                                          value: messenger
                                                              .id, // or messenger.id
                                                          child: Text(messenger.name
                                                              .toString()),
                                                        ))
                                                    .toList();
                                              } else {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'no_data',
                                                    child: Text('No Messengers'),
                                                    enabled: false,
                                                  )
                                                ];
                                              }
                                            },
                                          ),
                                          CircleAvatar(
                                            backgroundColor: themes.lightCream,
                                            // radius: 15,
                                            child: IconButton(
                                              onPressed: () {
                                                pickupController.openMapWithAddress(
                                                    data.address1.toString());
                                              },
                                              icon: Icon(
                                                Icons.gps_fixed,
                                                color: themes.darkCyanBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),*/