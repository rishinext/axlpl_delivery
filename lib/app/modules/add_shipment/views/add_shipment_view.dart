import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/add_shipment_controller.dart';

class AddShipmentView extends GetView<AddShipmentController> {
  const AddShipmentView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
    final Utils utils = Utils();
    String formatDate(DateTime date) {
      return DateFormat('dd/MM/yyyy').format(date); // Format the date
    }

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
                    sufixIcon: IconButton(
                        onPressed: () async {
                          await addshipController.pickDate(context);
                        },
                        icon: Icon(CupertinoIcons.calendar_today)),
                    hintTxt: formatDate(addshipController.selectedDate.value),
                  ),
                  dropdownText('Customer'),
                  Obx(() => CommonDropdown<CustomersList>(
                        hint: 'Select Customer',
                        selectedValue: controller.selectedCustomer.value,
                        isLoading: addshipController.isLoadingCustomers.value,
                        items: controller.customerList,
                        itemLabel: (c) => c.companyName ?? 'Unknown',
                        itemValue: (c) => c.id.toString(),
                        onChanged: (val) =>
                            controller.selectedCustomer.value = val,
                      )),
                  dropdownText('Category'),
                  Obx(() => CommonDropdown<CategoryList>(
                        hint: 'Select Category',
                        selectedValue: controller.selectedCategory.value,
                        isLoading: addshipController.isLoadingCate.value,
                        items: controller.categoryList,
                        itemLabel: (c) => c.name ?? 'Unknown',
                        itemValue: (c) => c.id.toString(),
                        onChanged: (val) {
                          controller.selectedCategory.value = val;
                          if (val != null) {
                            controller.selectedCommodity.value = null;

                            addshipController.commodityListData(val.toString());
                          }
                        },
                      )),
                  dropdownText('Commodity'),
                  Obx(() => CommonDropdown<CommodityList>(
                        hint: 'Select Comodity',
                        selectedValue: controller.selectedCommodity.value,
                        isLoading: addshipController.isLoadingCommodity.value,
                        items: controller.commodityList,
                        itemLabel: (c) => c.name ?? 'Unknown',
                        itemValue: (c) => c.id.toString(),
                        onChanged: (val) =>
                            controller.selectedCommodity.value = val,
                      )),
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
                  Obx(() => CommonDropdown<Map>(
                        hint: 'Select Payment',
                        selectedValue:
                            addshipController.selectedPaymentModeId.value,
                        isLoading: false,
                        items: addshipController.paymentModes,
                        itemLabel: (m) => m['name'] ?? '',
                        itemValue: (m) => m['id'],
                        onChanged: (val) {
                          log(val.toString());
                          addshipController.selectedPaymentModeId.value = val;
                        },
                      )),
                  Text(
                    'No of Parcel',
                    style: themes.fontSize14_400,
                  ),
                  CommomTextfiled(
                    hintTxt: 'Enter No of Parcel',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  dropdownText('Customer'),
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
