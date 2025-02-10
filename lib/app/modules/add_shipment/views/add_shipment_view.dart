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
    final addshipController = Get.put(AddShipmentController());
    final Utils utils = Utils();
    return SafeArea(
      child: CommonScaffold(
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
                      selectedValue: addshipController.selectedCustomer,
                      onChanged: (p0) {},
                      items: []),
                  dropdownText('Category'),
                  commomDropdown(
                      hint: 'select customer',
                      selectedValue: addshipController.selectedCustomer,
                      onChanged: (p0) {},
                      items: []),
                  dropdownText('Commodity'),
                  commomDropdown(
                      hint: 'select customer',
                      selectedValue: addshipController.selectedCustomer,
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
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: utils.validateText,
                          sufixIcon: InkWell(
                              child: Icon(CupertinoIcons.calendar_today)),
                        ),
                      ),
                      Expanded(
                        child: CommomTextfiled(
                          hintTxt: "Enter Gross weight",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          sufixIcon: InkWell(
                              child: Icon(CupertinoIcons.calendar_today)),
                          validator: utils.validateText,
                        ),
                      )
                    ],
                  ),
                  dropdownText('Payment Mode'),
                  commomDropdown(
                      hint: 'Select Payment Mode',
                      selectedValue: addshipController.selectedCustomer,
                      onChanged: (p0) {},
                      items: []),
                  dropdownText('Customer'),
                  commomDropdown(
                      hint: 'select customer',
                      selectedValue: addshipController.selectedCustomer,
                      onChanged: (p0) {},
                      items: []),
                  Row(
                    children: [
                      dropdownText('Insurance by AXLPL : '),
                      Spacer(),
                      Expanded(
                        child: Radio<String>(
                          value: "YES",
                          groupValue: addshipController.insuranceType.value,
                          activeColor: themes.orangeColor,
                          onChanged: (value) {
                            addshipController.insuranceType.value = value!;
                          },
                        ),
                      ),
                      Expanded(child: Text("YES")),
                      Expanded(
                        child: Radio<String>(
                          value: "NO",
                          groupValue: addshipController.insuranceType.value,
                          activeColor: themes.grayColor,
                          onChanged: (value) {
                            addshipController.insuranceType.value = value!;
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
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  Text(
                    'Insurance Value (₹)',
                    style: themes.fontSize14_400,
                  ),
                  CommomTextfiled(
                    hintTxt: 'Enter Insurance Value',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  Text(
                    'Remark',
                    style: themes.fontSize14_400,
                  ),
                  CommomTextfiled(
                    hintTxt: 'Enter Insurance Remark',
                    textInputAction: TextInputAction.done,
                    validator: utils.validateEmail,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
