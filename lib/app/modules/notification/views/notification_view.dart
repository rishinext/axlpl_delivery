import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/assets.dart';
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
        body: Obx(
          () {
            if (controller.isNotificationLoading.value == Status.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (controller.isNotificationLoading.value == Status.error ||
                controller.notiList.isEmpty) {
              return Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "No Notification Data Found!",
                  style: themes.fontSize16_400,
                ),
              );
            } else if (controller.isNotificationLoading.value ==
                Status.success) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.notiList.length,
                  itemBuilder: (context, index) {
                    final data = controller.notiList[index];
                    return ListTile(
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
                        data.title.toString(),
                        style: themes.fontSize14_500.copyWith(),
                      ),
                      subtitle: Text(data.message.toString()),
                      trailing: Text(
                        '${data.createdDate.toString().split(' ')[0]}',
                        style: themes.fontSize14_400.copyWith(fontSize: 13.sp),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text("No Notification Data Found!",
                    style: themes.fontSize16_400),
              );
            }
          },
        ));
  }
}
