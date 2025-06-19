import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
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
    final congimentController = Get.put(ConsignmentController());
    return CommonScaffold(
        appBar: commonAppbar('Consignment'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: [
                SizedBox(
                  height: 1.h,
                ),
                // Row(
                //   spacing: 10.w,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           controller.selectedContainer(0);
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: controller.isSelected.value == 0
                //                   ? themes.darkCyanBlue
                //                   : themes.whiteColor,
                //               borderRadius: BorderRadius.circular(
                //                 15.r,
                //               ),
                //               border: Border.all(
                //                 color: controller.isSelected.value == 0
                //                     ? themes.whiteColor
                //                     : themes.grayColor,
                //               )),
                //           child: Padding(
                //             padding: const EdgeInsets.all(10.0),
                //             child: Text(
                //               'Add Consignment',
                //               textAlign: TextAlign.center,
                //               style: themes.fontSize14_500.copyWith(
                //                   color: controller.isSelected.value == 0
                //                       ? themes.whiteColor
                //                       : themes.grayColor),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () {
                //           controller.selectedContainer(1);
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //               color: controller.isSelected.value == 1
                //                   ? themes.darkCyanBlue
                //                   : themes.whiteColor,
                //               borderRadius: BorderRadius.circular(
                //                 15.r,
                //               ),
                //               border: Border.all(
                //                 color: controller.isSelected.value == 1
                //                     ? themes.whiteColor
                //                     : themes.grayColor,
                //               )),
                //           child: Padding(
                //             padding: const EdgeInsets.all(10.0),
                //             child: Text(
                //               'Show Consignment',
                //               textAlign: TextAlign.center,
                //               style: themes.fontSize14_500.copyWith(
                //                   color: controller.isSelected.value == 1
                //                       ? themes.whiteColor
                //                       : themes.grayColor),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // controller.isSelected.value == 0
                //     ? Container(
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //             color: themes.whiteColor,
                //             borderRadius: BorderRadius.circular(4.r)),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             spacing: 10,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               // dropdownText('Source Branch'),
                //               /*  CommonDropdown(
                //                   hint: 'Mumbai',
                //                   selectedValue:
                //                       controller.selectedSourceBranch,
                //                   onChanged: (value) => controller
                //                       .selectedSourceBranch.value = value!,
                //                   items: controller.branches),
                //               dropdownText('Destination Branch'),
                //               CommonDropdown(
                //                   hint: 'Mumbai',
                //                   selectedValue:
                //                       controller.selectedSourceBranch,
                //                   onChanged: (value) => controller
                //                       .selectedSourceBranch.value = value!,
                //                   items: controller.branches),*/
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   dropdownText('Start Date'),
                //                   dropdownText('End Date')
                //                 ],
                //               ),
                //               Row(
                //                 spacing: 10,
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Expanded(
                //                     child: CommonTextfiled(
                //                       hintTxt:
                //                           "${controller.selectedStartDate.value.toLocal()}"
                //                               .split(" ")[0],
                //                       isReadOnly: true,
                //                       sufixIcon: InkWell(
                //                           onTap: () async {
                //                             final selectedDate =
                //                                 await holoDatePicker(
                //                                     context,
                //                                     initialDate: controller
                //                                             .selectedStartDate
                //                                             .value ??
                //                                         DateTime.now(),
                //                                     firstDate: DateTime(1950),
                //                                     lastDate: DateTime(2090),
                //                                     hintText:
                //                                         "Choose Start Date");

                //                             if (selectedDate != null) {
                //                               controller.selectedStartDate
                //                                   .value = selectedDate;
                //                             }
                //                           },
                //                           child: Icon(
                //                               CupertinoIcons.calendar_today)),
                //                     ),
                //                   ),
                //                   Expanded(
                //                     child: CommonTextfiled(
                //                       hintTxt:
                //                           "${controller.selectedEndDate.value.toLocal()}"
                //                               .split(" ")[0],
                //                       isReadOnly: true,
                //                       sufixIcon: InkWell(
                //                         onTap: () async {
                //                           final selectedDate =
                //                               await holoDatePicker(
                //                             context,
                //                             initialDate: controller
                //                                 .selectedEndDate.value,
                //                             firstDate: controller
                //                                 .selectedStartDate
                //                                 .value, // ✅ always after start
                //                             lastDate: DateTime(2090),
                //                             hintText: "Choose End Date",
                //                           );

                //                           if (selectedDate != null) {
                //                             controller.selectedEndDate.value =
                //                                 selectedDate;
                //                           }
                //                         },
                //                         child: Icon(
                //                             CupertinoIcons.calendar_today),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 20.h,
                //               ),
                //               CommonButton(
                //                 title: 'Load Shipment',
                //                 onPressed: () {},
                //               )
                //             ],
                //           ),
                //         ),
                //       )
                //     :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextfiled(
                      controller: congimentController.congimentControllerSearch,
                      onChanged: (val) {
                        congimentController.getConsigmentData(val);
                      },
                      hintTxt: 'Enter Consignment ID',
                      sufixIcon: IconButton(
                        onPressed: () async {
                          String? scannedValue =
                              await Utils().scanAndPlaySound(context);
                          if (scannedValue != null) {
                            congimentController.congimentControllerSearch.text =
                                scannedValue;
                            congimentController.getConsigmentData(scannedValue);
                          }
                        },
                        icon: const Icon(CupertinoIcons.qrcode_viewfinder),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(
                      () {
                        if (congimentController.isConsigementLoading.value ==
                            Status.loading) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (congimentController
                                    .isConsigementLoading.value ==
                                Status.error ||
                            congimentController.consignmentList.isEmpty) {
                          return Align(
                              alignment: Alignment.center,
                              child: Text('No Consignment Data Found!',
                                  style: themes.fontSize16_400));
                        } else if (congimentController
                                .isConsigementLoading.value ==
                            Status.success) {
                          return ListView.separated(
                            itemCount:
                                congimentController.consignmentList.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                            itemBuilder: (context, index) {
                              final data =
                                  congimentController.consignmentList[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color: themes.whiteColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    spacing: 10,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*  Column(
                                        spacing: 10,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: themes.blueGray,
                                            child: Icon(Icons.gps_fixed),
                                          ),
                                          Image.asset(
                                            arrowImg,
                                            height: 45.h,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: themes.blueGray,
                                            child: Image.asset(
                                              lolipopImg,
                                              width: 10.w,
                                            ),
                                          ),
                                        ],
                                      ),*/
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Source : ${data.origin}',
                                              style: themes.fontSize14_500
                                                  .copyWith(
                                                      color:
                                                          themes.darkCyanBlue),
                                            ),
                                            // SizedBox(
                                            //   width: 150.w,
                                            //   child: Text(
                                            //     'Lorem Ipsum is simply dummy text ',
                                            //     style: themes.fontSize14_400
                                            //         .copyWith(
                                            //             color:
                                            //                 themes.grayColor),
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'Destination : ${data.destination}',
                                              style: themes.fontSize14_500
                                                  .copyWith(
                                                      color:
                                                          themes.darkCyanBlue),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              'Shipment Date : ${data.shipmentDate?.split(' ')[0]}',
                                              style: themes.fontSize14_500
                                                  .copyWith(
                                                      color:
                                                          themes.darkCyanBlue),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: TextButton(
                                      //       style: TextButton.styleFrom(
                                      //           backgroundColor: themes.lightGrayColor,
                                      //           foregroundColor: themes.darkCyanBlue),
                                      //       onPressed: () {},
                                      //       child: Text('Choose')),
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Align(
                              alignment: Alignment.center,
                              child: Text(
                                'No Consignment Data Found!',
                                style: themes.fontSize16_400,
                              ));
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
