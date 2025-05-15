import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
    final bottomController = Get.put(BottombarController());
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
                  CommonTextfiled(
                    isReadOnly: true,
                    sufixIcon: IconButton(
                        onPressed: () async {
                          await addshipController.pickDate(
                              context, addshipController.selectedDate);
                        },
                        icon: Icon(CupertinoIcons.calendar_today)),
                    hintTxt: formatDate(addshipController.selectedDate.value),
                  ),
                  if (bottomController.userData.value?.role != 'customer')
                    dropdownText('Customer'),
                  if (bottomController.userData.value?.role != 'customer')
                    Obx(() {
                      return CommonDropdown<CustomersList>(
                        hint: 'Select Customer',
                        selectedValue: controller.selectedCustomer.value,
                        isLoading: addshipController.isLoadingCustomers.value,
                        items: controller.customerList,
                        itemLabel: (c) => c.companyName ?? 'Unknown',
                        itemValue: (c) => c.id.toString(),
                        onChanged: (val) =>
                            controller.selectedCustomer.value = val,
                      );
                    }),
                  // DropdownSearch<String>(
                  //   selectedItem: controller.selectedCustomer.value,
                  //   items: (filter, infiniteScrollProps) =>
                  //       ["Menu", "Dialog", "Modal", "BottomSheet"],
                  //   decoratorProps: DropDownDecoratorProps(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  //   popupProps: PopupProps.menu(
                  //       fit: FlexFit.loose, constraints: BoxConstraints()),
                  // ),

                  Obx(
                    () {
                      if (bottomController.userData.value?.role !=
                          'massanger') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dropdownText('Category'),
                            CommonDropdown<CategoryList>(
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

                                  addshipController
                                      .commodityListData(val.toString());
                                }
                              },
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            dropdownText('Category'),
                            Obx(() {
                              final isCustomerSelected =
                                  controller.selectedCustomer.value != null;
                              return GestureDetector(
                                onTap: () {
                                  if (!isCustomerSelected) {
                                    Get.snackbar(
                                      'Select Customer',
                                      'Please select a customer first',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: themes.redColor,
                                      colorText: themes.whiteColor,
                                    );
                                  }
                                },
                                behavior: HitTestBehavior.translucent,
                                child: AbsorbPointer(
                                  absorbing: !isCustomerSelected,
                                  child: CommonDropdown<CategoryList>(
                                    hint: 'Select Category',
                                    selectedValue:
                                        controller.selectedCategory.value,
                                    isLoading:
                                        addshipController.isLoadingCate.value,
                                    items: controller.categoryList,
                                    itemLabel: (c) => c.name ?? 'Unknown',
                                    itemValue: (c) => c.id.toString(),
                                    onChanged: (val) {
                                      controller.selectedCategory.value = val;
                                      if (val != null) {
                                        controller.selectedCommodity.value =
                                            null;

                                        addshipController
                                            .commodityListData(val.toString());
                                      }
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    },
                  ),
                  dropdownText('Commodity'),
                  Obx(
                    () {
                      final isCategorySelected =
                          controller.selectedCategory.value != null;
                      return GestureDetector(
                        onTap: () {
                          if (!isCategorySelected) {
                            Get.snackbar(
                              'Select Category',
                              'Please select a category first',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: themes.redColor,
                              colorText: themes.whiteColor,
                            );
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: AbsorbPointer(
                          absorbing: !isCategorySelected,
                          child: CommonDropdown<CommodityList>(
                            hint: 'Select Commodity',
                            selectedValue:
                                addshipController.selectedCommodity.value,
                            isLoading:
                                addshipController.isLoadingCommodity.value,
                            items: addshipController.commodityList,
                            itemLabel: (c) => c.name ?? 'Unknown',
                            itemValue: (c) => c.id.toString(),
                            onChanged: (val) =>
                                addshipController.selectedCommodity.value = val,
                          ),
                        ),
                      );
                    },
                  ),
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
                        child: CommonTextfiled(
                          controller: addshipController.netWeightController,
                          hintTxt: 'Enter Net Weight',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: utils.validateText,
                          sufixIcon: InkWell(
                              child: Icon(CupertinoIcons.calendar_today)),
                        ),
                      ),
                      Expanded(
                        child: CommonTextfiled(
                          controller: addshipController.grossWeightController,
                          onChanged: (p0) {
                            addshipController.calculateGrossWeight(
                              netWeight:
                                  addshipController.netWeightController.text,
                              grossWeight:
                                  addshipController.grossWeightController.text,
                              status: 'global',
                              productID: addshipController.selectedCommodity
                                  .toString(),
                            );
                          },
                          hintTxt: "Enter Gross weight",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          sufixIcon: InkWell(
                              child: Icon(CupertinoIcons.calendar_today)),
                          validator: (value) {
                            final net = double.tryParse(
                                addshipController.netWeightController.text);
                            final gross = double.tryParse(value ?? '');

                            if (value == null || value.isEmpty) {
                              return 'Gross weight is required';
                            }

                            if (net == null) return 'Net weight is invalid';
                            if (gross == null)
                              return 'Gross weight must be a number';

                            if (gross <= net) {
                              return 'Gross weight must be greater than net weight';
                            }

                            return null; //
                          },
                        ),
                      )
                    ],
                  ),
                  Text(
                    'No of Parcel',
                    style: themes.fontSize14_400,
                  ),
                  CommonTextfiled(
                    controller: addshipController.noOfParcelController,
                    hintTxt: 'Enter No of Parcel',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  dropdownText('Service Type'),
                  Obx(() => CommonDropdown<ServiceTypeList>(
                        hint: 'Select Service',
                        selectedValue: controller.selectedServiceType.value,
                        isLoading: addshipController.isServiceType.value,
                        items: controller.serviceTypeList,
                        itemLabel: (c) => c.name ?? 'Unknown',
                        itemValue: (c) => c.id.toString(),
                        onChanged: (val) =>
                            controller.selectedServiceType.value = val,
                      )),
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
                  CommonTextfiled(
                    hintTxt: 'Enter Policy No',
                    controller: addshipController.policyNoController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  Text(
                    'Expire Date',
                    style: themes.fontSize14_400,
                  ),
                  Obx(
                    () => CommonTextfiled(
                      isReadOnly: true,
                      sufixIcon: IconButton(
                          onPressed: () async {
                            await addshipController.pickDate(
                                context, addshipController.expireDate);
                          },
                          icon: Icon(CupertinoIcons.calendar_today)),
                      hintTxt: formatDate(addshipController.expireDate.value),
                    ),
                  ),
                  Text(
                    'Insurance Value (₹)',
                    style: themes.fontSize14_400,
                  ),
                  CommonTextfiled(
                    controller: addshipController.insuranceValueController,
                    hintTxt: 'Enter Insurance Value',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  Text(
                    'Invoice No',
                    style: themes.fontSize14_400,
                  ),
                  CommonTextfiled(
                    controller: addshipController.invoiceNoController,
                    hintTxt: 'Enter Invoice No',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: utils.validateText,
                  ),
                  Text(
                    'Remark',
                    style: themes.fontSize14_400,
                  ),
                  CommonTextfiled(
                    controller: addshipController.remarkController,
                    hintTxt: 'Enter Insurance Remark',
                    textInputAction: TextInputAction.done,
                    // validator: utils.validateText(value),
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
