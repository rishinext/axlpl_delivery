// Example widget to display the lists
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/running_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTrackingInfo() {
  final runningController = Get.put(RunningDeliveryDetailsController());
  if (runningController.isTrackingLoading.value == Status.loading) {
    return Center(child: CircularProgressIndicator());
  }

  if (runningController.isTrackingLoading.value == Status.error) {
    return Center(child: Text('Failed to load tracking data.'));
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tracking Status:', style: TextStyle(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: runningController.trackingStatus.length,
          itemBuilder: (_, index) {
            final status = runningController.trackingStatus[index];
            return ListTile(
              title: Text(status), // adjust accordingly if status is complex
            );
          },
        ),
        SizedBox(height: 16),
        Text('Sender Data:', style: TextStyle(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: runningController.senderData.length,
          itemBuilder: (_, index) {
            final sender = runningController.senderData[index];
            return ListTile(
              title: Text(sender), // adjust based on sender data structure
            );
          },
        ),
        SizedBox(height: 16),
        Text('Receiver Data:', style: TextStyle(fontWeight: FontWeight.bold)),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: runningController.receiverData.length,
          itemBuilder: (_, index) {
            final receiver = runningController.receiverData[index];
            return ListTile(
              title: Text(receiver), // adjust based on receiver data structure
            );
          },
        ),
      ],
    ),
  );
}
