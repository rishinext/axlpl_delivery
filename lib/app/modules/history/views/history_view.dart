import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final historyController = Get.put(HistoryController());
    final pickupDetailsController = Get.put(RunningDeliveryDetailsController());
    return CommonScaffold(
        appBar: commonAppbar('History'),
        body: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  // Row(
                  //   spacing: 10,
                  //   children: [
                  //     Expanded(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           historyController.selectedContainer(0);
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               color: historyController.isSelected.value == 0
                  //                   ? themes.darkCyanBlue
                  //                   : themes.whiteColor,
                  //               borderRadius: BorderRadius.circular(
                  //                 15.r,
                  //               ),
                  //               border: Border.all(
                  //                 color: historyController.isSelected.value == 0
                  //                     ? themes.whiteColor
                  //                     : themes.grayColor,
                  //               )),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Text(
                  //               "Delivery",
                  //               textAlign: TextAlign.center,
                  //               style: themes.fontSize14_500.copyWith(
                  //                   color:
                  //                       historyController.isSelected.value == 0
                  //                           ? themes.whiteColor
                  //                           : themes.grayColor),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           historyController.selectedContainer(1);
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               color: historyController.isSelected.value == 1
                  //                   ? themes.darkCyanBlue
                  //                   : themes.whiteColor,
                  //               borderRadius: BorderRadius.circular(
                  //                 15.r,
                  //               ),
                  //               border: Border.all(
                  //                 color: historyController.isSelected.value == 1
                  //                     ? themes.whiteColor
                  //                     : themes.grayColor,
                  //               )),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Text(
                  //               'Picked-up',
                  //               textAlign: TextAlign.center,
                  //               style: themes.fontSize14_500.copyWith(
                  //                   color:
                  //                       historyController.isSelected.value == 1
                  //                           ? themes.whiteColor
                  //                           : themes.grayColor),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  historyController.isSelected.value == 0
                      ? SizedBox(
                          height: 490.h,
                          child: Obx(() {
                            if (historyController.isDeliveredLoading.value ==
                                Status.loading) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                            if (historyController.historyList.isEmpty) {
                              return Center(
                                  child: Text(
                                'No History Data Found!',
                                style: themes.fontReboto16_600,
                              ));
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 1.h,
                                ),
                                itemCount: historyController.historyList.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final history =
                                      historyController.historyList[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r)),
                                    child: ListTile(
                                      tileColor: themes.whiteColor,
                                      dense: false,
                                      leading: CircleAvatar(
                                        backgroundColor: themes.blueGray,
                                        child: Image.asset(
                                          'assets/clockicon.png',
                                          width: 18.w,
                                        ),
                                      ),
                                      title: Text(
                                        "ShipmentId : ${history.shipmentId}",
                                        style: themes.fontSize14_400,
                                      ),
                                      subtitle: Column(
                                        spacing: 5,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Payment Mode : Cash'),
                                          Text('Amount : \u{20B9}19879'),
                                          Text(
                                              'Total cash Collected : \u{20B9}20020'),
                                        ],
                                      ),
                                      // trailing: CircleAvatar(
                                      //   backgroundColor: themes.lightCream,
                                      //   // radius: 15,
                                      //   child: Icon(
                                      //     Icons.arrow_forward,
                                      //     size: 20.w,
                                      //   ),
                                      // ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        )
                      : SizedBox(
                          height: 490.h,
                          child: Obx(() {
                            if (historyController.isPickedup.value ==
                                Status.loading) {
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
                                height: 1.h,
                              ),
                              itemCount:
                                  historyController.pickUpHistoryList.length,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var pickup =
                                    historyController.pickUpHistoryList[index];
                                return ListTile(
                                  onTap: () {
                                    pickupDetailsController.fetchTrackingData(
                                        pickup.shipmentId.toString());
                                    // Get.toNamed(
                                    //     Routes.RUNNING_DELIVERY_DETAILS);
                                  },
                                  tileColor: themes.whiteColor,
                                  dense: false,
                                  leading: CircleAvatar(
                                    backgroundColor: themes.blueGray,
                                    child: Image.asset(
                                      truckBlueIcon,
                                      width: 18.w,
                                    ),
                                  ),
                                  title: Text(
                                      '${pickup.cityName.toString()} : ${pickup.pincode}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(pickup.address1.toString())
                                    ],
                                  ),
                                  // trailing: CircleAvatar(
                                  //   backgroundColor: themes.lightCream,
                                  //   // radius: 15,
                                  //   child: Icon(
                                  //     Icons.arrow_forward,
                                  //     size: 20.w,
                                  //   ),
                                  // ),
                                );
                              },
                            );
                          }),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
