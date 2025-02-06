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
              ),
              dropdownText('Company Name'),
              CommomTextfiled(
                hintTxt: 'Company Name',
              ),
              dropdownText(zip),
              CommomTextfiled(
                hintTxt: 'Zip Code',
              ),
              dropdownText(state),
              CommomTextfiled(
                hintTxt: state,
              ),
              dropdownText(city),
              CommomTextfiled(
                hintTxt: city,
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
              ),
              dropdownText('Address Line 1'),
              CommomTextfiled(
                hintTxt: 'Address Line 1',
              ),
              dropdownText('Address Line 2'),
              CommomTextfiled(
                hintTxt: 'Address Line 2',
              ),
              dropdownText('Mobile'),
              CommomTextfiled(
                hintTxt: 'Mobile',
              ),
              dropdownText("Email"),
              CommomTextfiled(
                hintTxt: 'Email',
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
