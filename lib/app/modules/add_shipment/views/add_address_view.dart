import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/add_shipment_controller.dart';

class AddAddressView extends GetView {
  const AddAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
    final Utils utils = Utils();
    return CommonScaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: themes.whiteColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dropdownText('Sender Info'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Radio<String>(
                      value: "New Address",
                      groupValue: addshipController.addressType.value,
                      activeColor: themes.orangeColor,
                      onChanged: (value) {
                        addshipController.addressType.value = value!;
                      },
                    ),
                  ),
                  Text("New Address"),
                  Obx(() {
                    return Radio<String>(
                      value: "Existing Address",
                      groupValue: addshipController.addressType.value,
                      activeColor: themes.grayColor,
                      onChanged: (value) {
                        addshipController.addressType.value = value!;
                      },
                    );
                  }),
                  Text("Existing Address"),
                ],
              ),
              dropdownText('Name'),
              CommomTextfiled(
                hintTxt: 'Name',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText('Company Name'),
              CommomTextfiled(
                hintTxt: 'Company Name',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText(zip),
              CommomTextfiled(
                hintTxt: 'Zip Code',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
                keyboardType: TextInputType.number,
              ),
              dropdownText(state),
              CommomTextfiled(
                hintTxt: state,
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText(city),
              CommomTextfiled(
                hintTxt: city,
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText('Select Aera'),
              commomDropdown(
                  hint: 'select customer',
                  selectedValue: addshipController.selectedCustomer,
                  onChanged: (p0) {},
                  items: []),
              dropdownText('GST No'),
              CommomTextfiled(
                hintTxt: 'GST No',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText('Address Line 1'),
              CommomTextfiled(
                hintTxt: 'Address Line 1',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText('Address Line 2'),
              CommomTextfiled(
                hintTxt: 'Address Line 2',
                textInputAction: TextInputAction.next,
                validator: utils.validateText,
              ),
              dropdownText('Mobile'),
              CommomTextfiled(
                hintTxt: 'Mobile',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                validator: utils.validatePhone,
              ),
              dropdownText("Email"),
              CommomTextfiled(
                hintTxt: 'Email',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                validator: utils.validateText,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
