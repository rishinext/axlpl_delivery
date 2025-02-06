import 'package:axlpl_delivery/app/modules/add_shipment/views/add_address_view.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
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
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: themes.whiteColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Obx(
            () => Column(
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
                        sufixIcon:
                            InkWell(child: Icon(CupertinoIcons.calendar_today)),
                      ),
                    ),
                    Expanded(
                      child: CommomTextfiled(
                        hintTxt: "Enter Gross weight",
                        sufixIcon:
                            InkWell(child: Icon(CupertinoIcons.calendar_today)),
                      ),
                    )
                  ],
                ),
                dropdownText('Payment Mode'),
                commomDropdown(
                    hint: 'Select Payment Mode',
                    selectedValue: controller.selectedCustomer,
                    onChanged: (p0) {},
                    items: []),
                dropdownText('Customer'),
                commomDropdown(
                    hint: 'select customer',
                    selectedValue: controller.selectedCustomer,
                    onChanged: (p0) {},
                    items: []),
                Row(
                  children: [
                    dropdownText('Insurance by AXLPL : '),
                    Spacer(),
                    Expanded(
                      child: Radio<String>(
                        value: "YES",
                        groupValue: controller.insuranceType.value,
                        activeColor: themes.orangeColor,
                        onChanged: (value) {
                          controller.insuranceType.value = value!;
                        },
                      ),
                    ),
                    Expanded(child: Text("YES")),
                    Expanded(
                      child: Radio<String>(
                        value: "NO",
                        groupValue: controller.insuranceType.value,
                        activeColor: themes.grayColor,
                        onChanged: (value) {
                          controller.insuranceType.value = value!;
                        },
                      ),
                    ),
                    Expanded(child: Text("NO")),
                  ],
                ),
                Text(
                  'Policy No',
                  style: themes.fontSize14_400,
                ),
                CommomTextfiled(
                  hintTxt: 'Enter Policy No',
                ),
                Text(
                  'Insurance Value (₹)',
                  style: themes.fontSize14_400,
                ),
                CommomTextfiled(
                  hintTxt: 'Enter Insurance Value',
                ),
                Text(
                  'Remark',
                  style: themes.fontSize14_400,
                ),
                CommomTextfiled(
                  hintTxt: 'Enter Insurance Remark',
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
