import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/shipment_label_widget.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/shipnow_controller.dart';

class ShipnowView extends GetView<ShipnowController> {
  const ShipnowView({super.key});
  @override
  Widget build(BuildContext context) {
    final shipnowController = Get.put(ShipnowController());
    final runningController = Get.put(RunningDeliveryDetailsController());
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
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                              onTap: () {
                                runningController.fetchTrackingData(
                                    shipment.shipmentId.toString());
                                Get.toNamed(Routes.RUNNING_DELIVERY_DETAILS,
                                    arguments: {
                                      'shipmentID': shipment.shipmentId,
                                    });
                              },
                              child: ListTile(
                                title: Text(
                                  "Shipment Date: ${shipment.createdDate != null ? DateFormat('dd-MM-yyyy').format(shipment.createdDate!) : 'N/A'}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                        "Shipment ID: ${shipment.shipmentId ?? 'N/A'}"),
                                    Text(
                                        "Sender Company: ${shipment.senderCompanyName ?? 'N/A'}"),
                                    Text(
                                        "Receiver Company: ${shipment.receiverCompanyName ?? 'N/A'}"),
                                    Text("Orgin: ${shipment.origin ?? ''}"),
                                    Text(
                                        'Destination: ${shipment.destination ?? ''}'),
                                    Text(
                                        'Sender Area: ${shipment.senderAreaname ?? ''}'),
                                    Text(
                                        'Receiver Area: ${shipment.receiverAreaname ?? ''}'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Image.asset(
                                        //   status == 'Approved'
                                        //       ? appoved
                                        //       : status == 'Pending'
                                        //           ? historyIcon
                                        //           : status == 'Picked up'
                                        //               ? deliveryIcon
                                        //               : cancle,
                                        //   width: 25.w,
                                        // ),
                                        // Text(
                                        //   'Status:',s
                                        // ),
                                        // SizedBox(
                                        //   width: 8.w,
                                        // ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: status != 'Approved'
                                                ? Colors.orange[100]
                                                : Colors.green[100],
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: status,
                                                  style: theme.fontSize14_500
                                                      .copyWith(fontSize: 12.sp)
                                                      .copyWith(
                                                          color: status !=
                                                                  'Approved'
                                                              ? Colors
                                                                  .orange[900]
                                                              : Colors
                                                                  .green[900])),
                                            ])),
                                          ),
                                        ),
                                        if (status == 'Approved')
                                          CircleAvatar(
                                            radius: 15.h,
                                            backgroundColor: theme.greenColor,
                                            child: IconButton(
                                              color: theme.orangeColor,
                                              icon: Icon(
                                                size: 20.sp,
                                                Icons.qr_code,
                                                color: theme.whiteColor,
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    final labelController =
                                                        shipnowController
                                                            .getLableController(
                                                                shipment
                                                                    .shipmentId
                                                                    .toString());
                                                    return ShipmentLabelDialog(
                                                      labelCountController:
                                                          labelController,
                                                      onPrint: () {
                                                        final shipmentId =
                                                            shipment.shipmentId;
                                                        final labelCount =
                                                            labelController.text
                                                                    .isNotEmpty
                                                                ? labelController
                                                                    .text
                                                                : '1';
                                                        final url =
                                                            'https://new.axlpl.com/admin/shipment/shipment_manifest_pdf/$shipmentId/$labelCount';
                                                        controller
                                                            .downloadShipmentLable(
                                                                url,
                                                                shipmentId
                                                                    .toString());
                                                        Get.back();
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                      ],
                                    )
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
