import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
        appBar: AppBar(
          /*   actions: [
            PopupMenuButton(
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'CSV',
                  child: Text('CSV'),
                ),
                PopupMenuItem<String>(
                  value: 'Excel',
                  child: Text('Excel'),
                ),
                PopupMenuItem<String>(
                  value: 'PDF',
                  child: Text('PDF'),
                ),
                PopupMenuItem<String>(
                  value: 'Print',
                  child: Text('Print'),
                ),
              ],
            )
          ],*/
          title: const Text('My Shipments'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
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
                                        ? const CircularProgressIndicator()
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
                                  "Create Date: " +
                                      (shipment.createdDate != null
                                          ? shipment.createdDate!
                                              .toIso8601String()
                                              .split('T')[0]
                                          : 'N/A'),
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
                                    Row(
                                      children: [
                                        Text(
                                          'Status:',
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: status,
                                                style: theme.fontSize14_500
                                                    .copyWith(
                                                        color: status !=
                                                                'Approved'
                                                            ? theme.redColor
                                                            : theme.greenColor))
                                          ])),
                                        ),
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
