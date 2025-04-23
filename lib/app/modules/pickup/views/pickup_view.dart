import 'dart:developer';

import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/pickup_controller.dart';

class PickupView extends GetView<PickupController> {
  const PickupView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: commonAppbar('Pickup'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15.h,
            children: [
              ContainerTextfiled(
                hintText: '   Enter your pin code',
                suffixIcon: Icon(
                  CupertinoIcons.search,
                  color: themes.grayColor,
                ),
              ),
              Text(
                'Recent Selected Pin code',
                style: themes.fontSize14_500,
              ),
              SizedBox(
                height: 505.h,
                child: Obx(
                  () {
                    if (controller.isPickupLoading.value == Status.loading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (controller.isPickupLoading.value ==
                            Status.error ||
                        controller.pickupList.isEmpty) {
                      log(Status.error.toString());
                      return Center(
                        child: Text(
                          'No Pickup Data Found!',
                          style: themes.fontSize14_500,
                        ),
                      );
                    } else if (controller.isPickupLoading.value ==
                        Status.success) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1.h,
                        ),
                        itemCount: controller.pickupList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = controller.pickupList[index];
                          return ListTile(
                              tileColor: themes.whiteColor,
                              dense: false,
                              leading: CircleAvatar(
                                backgroundColor: themes.blueGray,
                                child: Image.asset(
                                  gpsIcon,
                                  width: 18.w,
                                ),
                              ),
                              title: Text(data.companyName.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.mobile.toString()),
                                  Text(data.pincode.toString()),
                                ],
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: themes.lightCream,
                                // radius: 15,
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 20.w,
                                ),
                              ));
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'No Pickup Found!',
                          style: themes.fontSize18_600,
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
