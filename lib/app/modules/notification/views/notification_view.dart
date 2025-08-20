import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/views/running_delivery_details_view.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    final runningDeliveryController =
        Get.put(RunningDeliveryDetailsController());
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
              return RefreshIndicator(
                onRefresh: () async {
                  controller.refreshData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: controller.scrollController,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemCount: controller.notiList.length +
                              (controller.hasMoreData.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.notiList.length) {
                              // Loading indicator at the bottom
                              return Obx(
                                  () => controller.isPaginationLoading.value
                                      ? Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          ),
                                        )
                                      : SizedBox.shrink());
                            }

                            final data = controller.notiList[index];
                            String dateString = data.createdDate.toString();
                            DateTime date = DateTime.parse(dateString);
                            String formattedDate =
                                DateFormat('d MMMM y').format(date);
                            return ListTile(
                              onTap: () async {
                                runningDeliveryController.fetchTrackingData(
                                    data.shipmentId.toString());
                                Get.to(
                                  RunningDeliveryDetailsView(
                                    isShowInvoice: true,
                                    isShowTransfer: true,
                                  ),
                                  arguments: {
                                    'shipmentID': data.shipmentId,
                                    // 'status': data.status.toString(),
                                    // 'invoicePath': data.invoicePath,
                                    // 'invoicePhoto': data.invoiceFile,
                                    // 'paymentMode': data.paymentMode,
                                    // 'date': data.date,
                                    // 'cashAmt': data.totalCharges
                                  },
                                );
                              },
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
                              subtitle: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.message.toString()),
                                  Text(
                                    formattedDate,
                                    style: themes.fontSize14_400
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: themes.blueGray,
                                child: Icon(Icons.arrow_forward),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
