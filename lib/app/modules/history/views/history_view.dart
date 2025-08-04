import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final historyController = Get.put(HistoryController());
    return CommonScaffold(
      appBar: commonAppbar('Cash Collection'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            // spacing: 20,
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
              Obx(() {
                // Calculate total cash amount from cashCollList
                double totalCashAmount = 0.0;
                for (var cash in historyController.cashCollList) {
                  if (cash.cashamount != null) {
                    try {
                      totalCashAmount +=
                          double.parse(cash.cashamount.toString());
                    } catch (e) {
                      // Handle parsing error if any
                    }
                  }
                }

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: themes.darkCyanBlue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                  // height: 10.h,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      spacing: 5,
                      children: [
                        Text('Today\'s Cash Collection',
                            textAlign: TextAlign.center,
                            style: themes.fontReboto16_600.copyWith(
                              color: themes.whiteColor,
                            )),
                        Text('\u{20B9}${totalCashAmount.toStringAsFixed(2)}',
                            style: themes.fontReboto16_600
                                .copyWith(color: themes.whiteColor)),
                      ],
                    ),
                  ),
                );
              }),
              Obx(() {
                if (historyController.isCashCollLoading.value ==
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
                    itemCount: historyController.cashCollList.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cash = historyController.cashCollList[index];

                      // Format date in Indian style (DD/MM/YYYY)
                      String formattedDate = "N/A";
                      if (cash.createdDate != null) {
                        try {
                          DateTime parsedDate =
                              DateTime.parse(cash.createdDate.toString());
                          formattedDate =
                              DateFormat('dd/MM/yyyy').format(parsedDate);
                        } catch (e) {
                          formattedDate = cash.createdDate.toString();
                        }
                      }

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
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
                            "ShipmentId : ${cash.shipmentId}",
                            style: themes.fontSize14_400,
                          ),
                          subtitle: Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Payment Mode : ${cash.paymentMode}'),
                              Text("Date : ${formattedDate}"),
                              // Text('Amount : \u{20B9}19879'),
                              Text(
                                'Amount : \u{20B9}${cash.cashamount}',
                              ),
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
