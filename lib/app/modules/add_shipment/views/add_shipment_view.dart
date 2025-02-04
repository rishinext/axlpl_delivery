import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/add_shipment_controller.dart';

class AddShipmentView extends GetView<AddShipmentController> {
  const AddShipmentView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Add Shipment'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                        style: themes.fontSize14_500
                            .copyWith(color: themes.grayColor, fontSize: 12.sp),
                      )
                    ],
                  ),
                  CircleAvatar()
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: themes.whiteColor,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Date',
                        style: themes.fontSize14_400,
                      ),
                      CommomTextfiled(
                        isReadOnly: true,
                        sufixIcon: Icon(CupertinoIcons.calendar),
                        hintTxt: '01/05/0224',
                      ),
                      dropdownText('Customer'),
                      commomDropdown(
                          hint: 'select customer',
                          selectedValue: controller.selectedCustomer,
                          onChanged: (p0) {},
                          items: []),
                      dropdownText('Category'),
                      commomDropdown(
                          hint: 'select customer',
                          selectedValue: controller.selectedCustomer,
                          onChanged: (p0) {},
                          items: []),
                      dropdownText('Commodity'),
                      commomDropdown(
                          hint: 'select customer',
                          selectedValue: controller.selectedCustomer,
                          onChanged: (p0) {},
                          items: []),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          dropdownText('Net Weight (GM)'),
                          dropdownText('Gross Weight (GM)')
                        ],
                      ),
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CommomTextfiled(
                              hintTxt: 'Enter Net Weight',
                              sufixIcon: InkWell(
                                  child: Icon(CupertinoIcons.calendar_today)),
                            ),
                          ),
                          Expanded(
                            child: CommomTextfiled(
                              hintTxt: "Enter Gross weight",
                              sufixIcon: InkWell(
                                  child: Icon(CupertinoIcons.calendar_today)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
