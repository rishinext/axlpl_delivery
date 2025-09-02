import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/paginated_dropdown.dart';
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
                  // Text(
                  //   'Select Date',
                  //   style: themes.fontSize14_400,
                  // ),
                  // CommonTextfiled(
                  //   isReadOnly: true,
                  //   sufixIcon: IconButton(
                  //       onPressed: () async {
                  //         await addshipController.pickDate(
                  //             context, addshipController.selectedDate);
                  //       },
                  //       icon: Icon(CupertinoIcons.calendar_today)),
                  //   hintTxt: formatDate(addshipController.selectedDate.value),
                  // ),
                  if (bottomController.userData.value?.role != 'customer')
                    dropdownText('Customer'),
                  if (bottomController.userData.value?.role != 'customer')
                    Obx(() {
                      return PaginatedDropdown<CustomersList>(
                        hint: 'Select Customer',
                        selectedValue: controller.selectedCustomer.value != null
                            ? controller.customerList.firstWhereOrNull(
                                (e) =>
                                    e.id == controller.selectedCustomer.value,
                              )
                            : null,
                        items: controller.customerList,
                        itemLabel: (customer) =>
                            customer.companyName ?? 'Unknown',
                        itemValue: (customer) => customer.id,
                        isLoading: addshipController.isLoadingCustomers.value,
                        isLoadingMore:
                            addshipController.isLoadingMoreCustomers.value,
                        hasMoreData: addshipController.hasMoreCustomers.value,
                        onLoadMore: () async {
                          await addshipController.loadMoreCustomers();
                        },
                        onChanged: (CustomersList? customer) {
                          if (customer != null) {
                            controller.selectedCustomer.value = customer.id;
                          }
                        },
                      );
                    }),
                  if (bottomController.userData.value?.role == 'customer')
                    dropdownText('Company Name'),
                  if (bottomController.userData.value?.role == 'customer')
                    Obx(
                      () => CommonTextfiled(
                        hintTxt: bottomController
                            .userData.value?.customerdetail?.companyName,
                        isEnable: false,
                      ),
                    ),
                  // DropdownSearch<String>(
                  //   selectedItem: controller.selectedCustomer.value,
                  //   items: (filter, infiniteScrollProps) =>
                  //       ["Menu", "Dialog", "Modal", "BottomSheet"],
                  //   decoratorProps: DropDownDecoratorProps(
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),x
                  //   popupProps: PopupProps.menu(
                  //       fit: FlexFit.loose, constraints: BoxConstraints()),
                  // ),

                  Obx(
                    () {
                      if (bottomController.userData.value?.role == 'customer') {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dropdownText('Category'),
                            Obx(() => PaginatedDropdown<CategoryList>(
                                  hint: 'Select Category',
                                  selectedValue:
                                      controller.selectedCategory.value != null
                                          ? controller.categoryList
                                              .firstWhereOrNull(
                                              (e) =>
                                                  e.id ==
                                                  controller
                                                      .selectedCategory.value,
                                            )
                                          : null,
                                  items: controller.categoryList,
                                  itemLabel: (category) =>
                                      category.name ?? 'Unknown',
                                  itemValue: (category) => category.id,
                                  isLoading:
                                      addshipController.isLoadingCate.value,
                                  isLoadingMore: addshipController
                                      .isLoadingMoreCategories.value,
                                  hasMoreData:
                                      addshipController.hasMoreCategories.value,
                                  onLoadMore: () async {
                                    await addshipController
                                        .loadMoreCategories();
                                  },
                                  onChanged: (CategoryList? category) async {
                                    if (category != null) {
                                      controller.selectedCategory.value =
                                          category.id;
                                      controller.selectedCommodity.value = null;
                                      await addshipController
                                          .getContractDetails(
                                              controller.selectedCustomer.value,
                                              category.id.toString());
                                      await addshipController.commodityListData(
                                          category.id.toString(), '0');
                                    }
                                  },
                                )),
                          ],
                        );
                      } else {
                        return Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: Obx(() =>
                                      PaginatedDropdown<CategoryList>(
                                        hint: 'Select Category',
                                        selectedValue:
                                            controller.selectedCategory.value !=
                                                    null
                                                ? controller.categoryList
                                                    .firstWhereOrNull(
                                                    (e) =>
                                                        e.id ==
                                                        controller
                                                            .selectedCategory
                                                            .value,
                                                  )
                                                : null,
                                        items: controller.categoryList,
                                        itemLabel: (category) =>
                                            category.name ?? 'Unknown',
                                        itemValue: (category) => category.id,
                                        isLoading: addshipController
                                            .isLoadingCate.value,
                                        isLoadingMore: addshipController
                                            .isLoadingMoreCategories.value,
                                        hasMoreData: addshipController
                                            .hasMoreCategories.value,
                                        onLoadMore: () async {
                                          await addshipController
                                              .loadMoreCategories();
                                        },
                                        onChanged:
                                            (CategoryList? category) async {
                                          if (category != null) {
                                            controller.selectedCategory.value =
                                                category.id;
                                            controller.selectedCommodity.value =
                                                null;
                                            await addshipController
                                                .getContractDetails(
                                              controller.selectedCustomer.value,
                                              category.id.toString(),
                                            );
                                            addshipController.commodityListData(
                                              category.id.toString(),
                                              '0',
                                            );
                                          }
                                        },
                                      )),
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
                      if (controller.isLoadingCommodity.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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
                          child: Obx(() => PaginatedDropdown<CommodityList>(
                                hint: 'Select Commodity',
                                selectedValue:
                                    addshipController.selectedCommodity.value !=
                                            null
                                        ? addshipController.commodityList
                                            .firstWhereOrNull(
                                            (e) =>
                                                e.id ==
                                                addshipController
                                                    .selectedCommodity.value,
                                          )
                                        : null,
                                items: addshipController.commodityList,
                                itemLabel: (commodity) =>
                                    commodity.name ?? 'Unknown',
                                itemValue: (commodity) => commodity.id,
                                isLoading:
                                    addshipController.isLoadingCommodity.value,
                                isLoadingMore: addshipController
                                    .isLoadingMoreCommodities.value,
                                hasMoreData:
                                    addshipController.hasMoreCommodities.value,
                                onLoadMore: () async {
                                  if (controller.selectedCategory.value !=
                                      null) {
                                    await addshipController.loadMoreCommodities(
                                        controller.selectedCategory.value
                                            .toString());
                                  }
                                },
                                onChanged: (CommodityList? commodity) {
                                  if (commodity != null) {
                                    addshipController.selectedCommodity.value =
                                        commodity.id;
                                  }
                                },
                              )),
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
                            // addshipController.calculateGrossWeight(
                            //   netWeight:
                            //       addshipController.netWeightController.text,
                            //   grossWeight:
                            //       addshipController.grossWeightController.text,
                            //   status: 'global',
                            //   productID: addshipController.selectedCommodity
                            //       .toString(),
                            // );
                            return null;
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
                        child: Radio(
                          value: 0,
                          groupValue: addshipController.insuranceType.value,
                          activeColor: themes.orangeColor,
                          onChanged: (value) {
                            addshipController.insuranceType.value = value!;
                            log(value.toString());
                          },
                        ),
                      ),
                      Expanded(child: Text("YES")),
                      Expanded(
                        child: Radio(
                          value: 1,
                          groupValue: addshipController.insuranceType.value,
                          activeColor: themes.grayColor,
                          onChanged: (value) {
                            addshipController.insuranceType.value = value!;
                            log(value.toString());
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
                  Obx(
                    () => CommonTextfiled(
                        isEnable: addshipController.insuranceType.value == 1
                            ? true
                            : false,
                        hintTxt: 'Enter Policy No',
                        controller: addshipController.policyNoController,
                        // keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: addshipController.insuranceType.value == 1
                            ? utils.validateText
                            : null),
                  ),
                  Text(
                    'Expire Date',
                    style: themes.fontSize14_400,
                  ),
                  Obx(
                    () => CommonTextfiled(
                      isReadOnly: true,
                      isEnable: addshipController.insuranceType.value == 1
                          ? true
                          : false,
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
                  Obx(
                    () => CommonTextfiled(
                      isEnable: addshipController.insuranceType.value == 1
                          ? true
                          : false,
                      controller: addshipController.insuranceValueController,
                      hintTxt: 'Enter Insurance Value',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: addshipController.insuranceType.value == 1
                          ? utils.validateText
                          : null,
                    ),
                  ),
                  Text(
                    'Invoice Value',
                    style: themes.fontSize14_400,
                  ),
                  CommonTextfiled(
                    controller: addshipController.invoiceValueController,
                    hintTxt: 'Enter Invoice Value',
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
                    // keyboardType: TextInputType.number,
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
