import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shipnow_controller.dart';

class ShipnowView extends GetView<ShipnowController> {
  const ShipnowView({super.key});
  @override
  Widget build(BuildContext context) {
    final shipnowController = Get.put(ShipnowController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShipnowView'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (shipnowController.isLoadingShipNow.value) {
            Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (shipnowController.shipmentDataList.isEmpty) {
            return ListView.builder(
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
              child: Text('No Shipment Data Found!'),
            );
          }
        },
      ),
    );
  }
}
