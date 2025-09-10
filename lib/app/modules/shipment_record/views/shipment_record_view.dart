import 'dart:io';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/shipnow/controllers/shipnow_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/shipment_label_widget.dart';
import 'package:axlpl_delivery/common_widget/tracking_info_widget.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/shipment_record_controller.dart';

class ShipmentRecordView extends GetView<ShipmentRecordController> {
  const ShipmentRecordView({super.key});
  @override
  Widget build(BuildContext context) {
    final shipnowController = Get.put(ShipnowController());
    final runningController = Get.put(RunningDeliveryDetailsController());
    final shipmentController = Get.put(ShipnowController());
    final theme = Themes();
    final ScrollController scrollController = ScrollController();

    // Infinite scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          shipnowController.hasMoreData &&
          !shipnowController.isLoadingMore.value &&
          !shipnowController.isLoadingShipNow.value) {
        shipnowController.loadMoreData();
      }
    });
    return CommonScaffold(
        appBar: commonAppbar('My Shipments'),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
              Platform.isIOS
                  ? SizedBox(
                      height: 2.h,
                    )
                  : SizedBox.shrink(),
              ContainerTextfiled(
                controller: shipnowController.shipmentIDController,
                hintText: 'Search Here',
                onChanged: (value) {
                  // shipnowController.filterByQuery(value!);
                  return null;
                },
                suffixIcon: Icon(CupertinoIcons.search),
                prefixIcon: InkWell(
                  onTap: () async {
                    var scannedValue = await Utils().scanAndPlaySound(context);
                    if (scannedValue != null && scannedValue != '-1') {
                      shipnowController.shipmentIDController.text =
                          scannedValue;
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
                        },
                      );
                    }
                  },
                  child: Icon(CupertinoIcons.qrcode_viewfinder),
                ),
              ),

              // Sort by Filter Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.filter_list,
                    color: theme.whiteColor,
                  ),
                  label: Obx(() => Text(
                        shipnowController.selectedStatusFilter.value.isEmpty
                            ? 'Sort by Status'
                            : shipnowController.selectedStatusFilter.value,
                        style: theme.fontSize14_500,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.darkCyanBlue,
                    foregroundColor: theme.whiteColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    if (Platform.isIOS) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (ctx) => CupertinoActionSheet(
                          title: Text('Select Status Filter'),
                          actions:
                              shipnowController.statusFilters.map((status) {
                            return CupertinoActionSheetAction(
                              onPressed: () {
                                shipnowController.setStatusFilter(status);
                                Navigator.of(ctx).pop();
                              },
                              child: Text(status.isEmpty ? 'All' : status),
                            );
                          }).toList(),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('Cancel'),
                          ),
                        ),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Select Status Filter',
                                  style: theme.fontSize14_500),
                            ),
                            ...shipnowController.statusFilters.map((status) =>
                                ListTile(
                                  title: Text(status.isEmpty ? 'All' : status),
                                  onTap: () {
                                    shipnowController.setStatusFilter(status);
                                    Navigator.of(ctx).pop();
                                  },
                                ))
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Obx(() {
                if (shipnowController.isLoadingShipNow.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (shipnowController.filteredShipmentData.isNotEmpty) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: shipnowController.refreshData,
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount:
                            shipnowController.filteredShipmentData.length +
                                (shipnowController.hasMoreData ? 1 : 0),
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          // Show loading indicator at the end
                          if (index ==
                              shipnowController.filteredShipmentData.length) {
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: shipnowController.isLoadingMore.value
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : const SizedBox.shrink(),
                                  ),
                                ));
                          }

                          final shipment =
                              shipnowController.filteredShipmentData[index];
                          final status = shipment.shipmentStatus;
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: theme.whiteColor,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 12.r,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                runningController.fetchTrackingData(
                                    shipment.shipmentId.toString());
                                Get.toNamed(Routes.RUNNING_DELIVERY_DETAILS,
                                    arguments: {
                                      'shipmentID': shipment.shipmentId,
                                    });
                              },
                              borderRadius: BorderRadius.circular(16.r),
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header Row with Date and Status
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Date Section
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: theme.darkCyanBlue
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 14.sp,
                                                color: theme.darkCyanBlue,
                                              ),
                                              SizedBox(width: 6.w),
                                              Text(
                                                "${shipment.createdDate != null ? DateFormat('dd MMM yy').format(shipment.createdDate!) : 'N/A'}",
                                                style: theme.fontSize14_500
                                                    .copyWith(
                                                  color: theme.darkCyanBlue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Status Badge
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: status == 'Approved'
                                                ? Colors.green[50]
                                                : status == 'Pending'
                                                    ? Colors.orange[50]
                                                    : Colors.red[50],
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            border: Border.all(
                                              color: status == 'Approved'
                                                  ? Colors.green[200]!
                                                  : status == 'Pending'
                                                      ? Colors.orange[200]!
                                                      : Colors.red[200]!,
                                              width: 1.w,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 6.w,
                                                height: 6.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: status == 'Approved'
                                                      ? Colors.green[600]
                                                      : status == 'Pending'
                                                          ? Colors.orange[600]
                                                          : Colors.red[600],
                                                ),
                                              ),
                                              SizedBox(width: 6.w),
                                              Text(
                                                status ?? 'Unknown',
                                                style: theme.fontSize14_500
                                                    .copyWith(
                                                  color: status == 'Approved'
                                                      ? Colors.green[700]
                                                      : status == 'Pending'
                                                          ? Colors.orange[700]
                                                          : Colors.red[700],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),

                                    // Shipment ID Row
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.local_shipping_outlined,
                                          size: 18.sp,
                                          color: theme.darkCyanBlue,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "ID: ",
                                          style: theme.fontSize14_400.copyWith(
                                            color: theme.grayColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${shipment.shipmentId ?? 'N/A'}",
                                            style:
                                                theme.fontSize14_500.copyWith(
                                              color: theme.blackColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12.h),

                                    // Company Names Section
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Column(
                                        children: [
                                          // Sender
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(6.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[100],
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.business,
                                                  size: 14.sp,
                                                  color: Colors.blue[700],
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "From",
                                                      style: theme
                                                          .fontSize14_400
                                                          .copyWith(
                                                        color: theme.grayColor,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${shipment.senderCompanyName ?? 'N/A'}",
                                                      style: theme
                                                          .fontSize14_500
                                                          .copyWith(
                                                        color: theme.blackColor,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    if (shipment.senderAreaname
                                                            ?.isNotEmpty ==
                                                        true)
                                                      Text(
                                                        "${shipment.senderAreaname}",
                                                        style: theme
                                                            .fontSize14_400
                                                            .copyWith(
                                                          color:
                                                              theme.grayColor,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12.h),
                                          // Arrow Divider
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Divider(
                                                      color: Colors.grey[300])),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                child: Icon(
                                                  Icons.arrow_downward,
                                                  size: 16.sp,
                                                  color: theme.darkCyanBlue,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Divider(
                                                      color: Colors.grey[300])),
                                            ],
                                          ),
                                          SizedBox(height: 12.h),
                                          // Receiver
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(6.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[100],
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.location_on,
                                                  size: 14.sp,
                                                  color: Colors.green[700],
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "To",
                                                      style: theme
                                                          .fontSize14_400
                                                          .copyWith(
                                                        color: theme.grayColor,
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${shipment.receiverCompanyName ?? 'N/A'}",
                                                      style: theme
                                                          .fontSize14_500
                                                          .copyWith(
                                                        color: theme.blackColor,
                                                      ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    if (shipment
                                                            .receiverAreaname
                                                            ?.isNotEmpty ==
                                                        true)
                                                      Text(
                                                        "${shipment.receiverAreaname}",
                                                        style: theme
                                                            .fontSize14_400
                                                            .copyWith(
                                                          color:
                                                              theme.grayColor,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),

                                    // Route Information
                                    if (shipment.origin?.isNotEmpty == true ||
                                        shipment.destination?.isNotEmpty ==
                                            true)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: theme.darkCyanBlue
                                              .withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: theme.darkCyanBlue
                                                .withOpacity(0.1),
                                            width: 1.w,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.route,
                                              size: 16.sp,
                                              color: theme.darkCyanBlue,
                                            ),
                                            SizedBox(width: 8.w),
                                            Expanded(
                                              child: Text(
                                                "${shipment.origin ?? ''} ${shipment.origin?.isNotEmpty == true && shipment.destination?.isNotEmpty == true ? '→' : ''} ${shipment.destination ?? ''}",
                                                style: theme.fontSize14_500
                                                    .copyWith(
                                                  color: theme.darkCyanBlue,
                                                  fontSize: 13.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    // QR Code Button for Approved Status
                                    // if (status == 'Approved')
                                    //   Column(
                                    //     children: [
                                    //       SizedBox(height: 12.h),
                                    //       Container(
                                    //         width: double.infinity,
                                    //         child: ElevatedButton.icon(
                                    //           onPressed: () {
                                    //             showDialog(
                                    //               context: context,
                                    //               builder: (context) {
                                    //                 final labelController =
                                    //                     shipnowController
                                    //                         .getLableController(
                                    //                             shipment
                                    //                                 .shipmentId
                                    //                                 .toString());
                                    //                 return ShipmentLabelDialog(
                                    //                   labelCountController:
                                    //                       labelController,
                                    //                   onPrint: () {
                                    //                     final shipmentId =
                                    //                         shipment.shipmentId;
                                    //                     final labelCount =
                                    //                         labelController.text
                                    //                                 .isNotEmpty
                                    //                             ? labelController
                                    //                                 .text
                                    //                             : '1';
                                    //                     final url =
                                    //                         'https://new.axlpl.com/admin/shipment/shipment_manifest_pdf/$shipmentId/$labelCount';
                                    //                     shipnowController
                                    //                         .downloadShipmentLable(
                                    //                             url,
                                    //                             shipmentId
                                    //                                 .toString());
                                    //                     Get.back();
                                    //                   },
                                    //                 );
                                    //               },
                                    //             );
                                    //           },
                                    //           icon: Icon(
                                    //             Icons.qr_code,
                                    //             size: 18.sp,
                                    //             color: theme.whiteColor,
                                    //           ),
                                    //           label: Text(
                                    //             'Generate Label',
                                    //             style: theme.fontSize14_500
                                    //                 .copyWith(
                                    //               color: theme.whiteColor,
                                    //             ),
                                    //           ),
                                    //           style: ElevatedButton.styleFrom(
                                    //             backgroundColor:
                                    //                 theme.darkCyanBlue,
                                    //             foregroundColor:
                                    //                 theme.whiteColor,
                                    //             padding: EdgeInsets.symmetric(
                                    //                 vertical: 12.h),
                                    //             shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       10.r),
                                    //             ),
                                    //             elevation: 2,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Shipment Data Found!',
                      style: theme.fontReboto16_600,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              }),

              /*   Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  // padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) => Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      // onTap: () => showDetailsDialog(shipment),
                      title: Text(
                        "Shipment ID: ${['shipmentId']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Date: ${['createdDate']}"),
                          Text("Sender: ${['senderCompany']}"),
                          Text("Receiver: ${['receiverCompany']}"),
                          Text("Route: ${['origin']} to ${['destination']}"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ));
  }
}
