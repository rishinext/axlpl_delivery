import 'package:axlpl_delivery/app/modules/add_shipment/controllers/add_shipment_controller.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_different_address_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_payment_info_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/add_shipment_view.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/views/receiver_address_view.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class PageviewView extends GetView {
  const PageviewView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
    return CommonScaffold(
        appBar: commonAppbar('Add Shipment'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Details',
                          style: themes.fontSize14_500,
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text ',
                          style: themes.fontSize14_500.copyWith(
                              color: themes.grayColor, fontSize: 12.sp),
                        )
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: themes.lightCream,
                      radius: 25,
                      child: Text(
                          '${addshipController.currentPage.value + 1}/${addshipController.totalPage.value}',
                          style: themes.fontSize18_600
                              .copyWith(color: themes.darkCyanBlue)),
                    )
                  ],
                ),
                Expanded(
                  child: PageView(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    controller: addshipController.pageController,
                    onPageChanged: (value) =>
                        addshipController.currentPage.value = value,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Form(
                        key: addshipController.formKeys[0],
                        child: AddShipmentView(),
                      ),
                      Form(
                        key: addshipController.formKeys[1],
                        child: AddAddressView(),
                      ),
                      Form(
                        key: addshipController.formKeys[2],
                        child: ReceiverAddressView(),
                      ),
                      Form(
                        key: addshipController.formKeys[3],
                        child: AddDifferentAddressView(),
                      ),
                      Form(
                        key: addshipController.formKeys[4],
                        child: AddPaymentInfoView(),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    addshipController.currentPage.value != 0
                        ? CircleAvatar(
                            backgroundColor: themes.lightGrayColor,
                            child: IconButton(
                                onPressed: () {
                                  addshipController.previousPage();
                                },
                                icon: Icon(Icons.arrow_back)),
                          )
                        : SizedBox.shrink(),
                    Spacer(),
                    Expanded(
                      child: CommonButton(
                          onPressed: () {
                            int current = addshipController.currentPage.value;

                            final isValid = addshipController
                                    .formKeys[current].currentState
                                    ?.validate() ??
                                false;

                            if (!isValid) return;
                            addshipController.shipmentData =
                                addshipController.collectFormData(
                                    addshipController.currentPage.value);

                            if (current == 4) {
                              // Submit
                              // addshipController.submitShipment();
                            } else {
                              addshipController.nextPage();
                            }
                          },
                          title: addshipController.currentPage.value == 4
                              ? 'Submit'
                              : 'Next'),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
