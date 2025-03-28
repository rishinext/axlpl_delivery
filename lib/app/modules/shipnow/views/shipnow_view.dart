import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shipnow_controller.dart';

class ShipnowView extends GetView<ShipnowController> {
  const ShipnowView({super.key});
  @override
  Widget build(BuildContext context) {
    final shipnowController = Get.put(ShipnowController());
    final theme = Themes();
    return Scaffold(
        appBar: AppBar(
          actions: [
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
          ],
          title: const Text('All Shipments'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            spacing: 10,
            children: [
              CommonTextfiled(
                hintTxt: 'Search Here',
                sufixIcon: Icon(Icons.search),
              ),
              Expanded(
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
              ),
            ],
          ),
        )
        /*Obx(
        () {
          if (shipnowController.isLoadingShipNow.value) {
            Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (shipnowController.shipmentDataList.isNotEmpty) {
            return 
            ListView.builder(
              shrinkWrap: true,
              itemCount: shipnowController.shipmentDataList.length,
              padding: EdgeInsets.all(8),
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
            );
          } else {
            return Center(
              child: Text(
                'No Shipment Data Found!',
                style: theme.fontReboto16_600,
              ),
            );
          }
        },
      ),*/
        );
  }
}
