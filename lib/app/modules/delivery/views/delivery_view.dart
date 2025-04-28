import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/delivery_controller.dart';

class DeliveryView extends GetView<DeliveryController> {
  const DeliveryView({super.key});
  @override
  Widget build(BuildContext context) {
    final deliveryController = Get.put(DeliveryController());
    final pickupController = Get.put(PickupController());
    return CommonScaffold(
      appBar: commonAppbar('Delivery'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15.h,
            children: [
              ContainerTextfiled(
                hintText: '   Enter your pin code',
                controller: deliveryController.pincodeController,
                onChanged: (value) {
                  deliveryController.filterByPincode(value!);
                  return null;
                },
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
                    if (deliveryController.isDeliveryLoading.value ==
                        Status.loading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (deliveryController.isDeliveryLoading.value ==
                            Status.error ||
                        deliveryController.filteredDeliveryList.isEmpty) {
                      return Center(
                        child: Text(
                          'No Pickup Data Found!',
                          style: themes.fontSize14_500,
                        ),
                      );
                    } else if (deliveryController.isDeliveryLoading.value ==
                        Status.success) {
                      return ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 1.h,
                        ),
                        itemCount:
                            deliveryController.filteredDeliveryList.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data =
                              deliveryController.filteredDeliveryList[index];
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
                                child: IconButton(
                                  onPressed: () {
                                    pickupController.openMapWithAddress(
                                        data.address1.toString());
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    size: 20.w,
                                  ),
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
