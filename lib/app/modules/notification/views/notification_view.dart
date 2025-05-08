import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Notifications'),
        body: Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () {
                if (controller.isNotificationLoading.value == Status.loading) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (controller.isNotificationLoading.value ==
                        Status.error ||
                    controller.notiList.isEmpty) {
                  return Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "No Notification Data Found!",
                      style: themes.fontSize14_500,
                    ),
                  );
                } else if (controller.isNotificationLoading.value ==
                    Status.success) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.notiList.length,
                    itemBuilder: (context, index) {
                      final data = controller.notiList[index];
                      return Text(data.title.toString());
                    },
                  );
                } else {
                  return Center(
                    child: Text("No Notification Data Found!",
                        style: themes.fontSize14_500),
                  );
                }
              },
            )
          ],
        ));
  }
}
