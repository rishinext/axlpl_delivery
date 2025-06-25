import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/payment_mode_model.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/controllers/add_shipment_controller.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AddPaymentInfoView extends GetView {
  const AddPaymentInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
    final pickupController = Get.put(PickupController());
    return CommonScaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: themes.whiteColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dropdownText('Payment Information'),

                    dropdownText('Payment Mode'),
                    // Obx(() => CommonDropdown<Map>(
                    //       hint: 'Select Payment',
                    //       selectedValue:
                    //           addshipController.selectedPaymentModeId.value,
                    //       isLoading: false,
                    //       items: addshipController.paymentModes,
                    //       itemLabel: (m) => m['name'] ?? '',
                    //       itemValue: (m) => m['id'],
                    //       onChanged: (val) {
                    //         log(val.toString());
                    //         addshipController.selectedPaymentModeId.value = val;
                    //         log(val.toString());
                    //       },
                    //     )),
                    Obx(
                      () {
                        if (pickupController.isLoadingPayment.value) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          return DropdownSearch<PaymentMode>(
                            items: pickupController.paymentModes,
                            selectedItem:
                                addshipController.selectedPaymentMode.value,
                            onChanged: (PaymentMode? newValue) {
                              addshipController
                                  .setSelectedPaymentMode(newValue);
                              addshipController.shipmentCal(
                                int.parse(
                                    addshipController.selectedCustomer.value),
                                int.parse(
                                    addshipController.selectedCategory.value),
                                int.parse(
                                    addshipController.selectedCommodity.value),
                                int.parse(addshipController
                                    .netWeightController.text
                                    .trim()),
                                int.parse(addshipController
                                    .grossWeightController.text
                                    .trim()),
                                addshipController.selectedPaymentMode.value?.id,
                                addshipController.insuranceValueController.text
                                    .trim(),
                                addshipController.insuranceType.value,
                                addshipController.policyNoController.text,
                                int.parse(addshipController
                                    .noOfParcelController.text
                                    .trim()),
                                addshipController.expireDate.value.toString(),
                                addshipController.insuranceValueController.text
                                    .trim(),
                                addshipController
                                    .existingSenderInfoZipController.text,
                                addshipController
                                    .receiverInfoZipController.text,
                              );
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                // labelText: 'Select Payment Mode',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                              ),
                            ),
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              showSearchBox: false,
                              searchFieldProps: TextFieldProps(
                                decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              itemBuilder: (context, item, isSelected) {
                                return ListTile(
                                  selected: isSelected,
                                  title: Text(item.name),
                                );
                              },
                            ),
                            dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.name ?? 'Select Payment Mode',
                              style: TextStyle(
                                  color: selectedItem == null
                                      ? Colors.grey.shade600
                                      : null),
                            ),
                          );
                        }
                      },
                    ),

                    dropdownText('Sub Payment Info'),
                    // Obx(() => CommonDropdown<Map>(
                    //       hint: 'Select Payment',
                    //       selectedValue:
                    //           addshipController.selectedSubPaymentId.value,
                    //       isLoading: false,
                    //       items: addshipController.subPaymentModes,
                    //       itemLabel: (m) => m['name'] ?? '',
                    //       itemValue: (m) => m['id'],
                    //       onChanged: (val) {
                    //         log(val.toString());
                    //         addshipController.selectedSubPaymentId.value = val;
                    //       },
                    //     )),
                    Obx(
                      () {
                        if (pickupController.isLoadingPayment.value) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          return DropdownSearch<PaymentMode>(
                            items: pickupController.subPaymentModes,
                            selectedItem:
                                addshipController.selectedSubPaymentMode.value,
                            onChanged: (PaymentMode? newValue) {
                              addshipController
                                  .setSelectedSubPaymentMode(newValue);
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                // labelText: 'Select Payment Mode',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                              ),
                            ),
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              showSearchBox: false,
                              searchFieldProps: TextFieldProps(
                                decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              itemBuilder: (context, item, isSelected) {
                                return ListTile(
                                  selected: isSelected,
                                  title: Text(item.name),
                                );
                              },
                            ),
                            dropdownBuilder: (context, selectedItem) => Text(
                              selectedItem?.name ?? 'Select SubPayment Mode',
                              style: TextStyle(
                                  color: selectedItem == null
                                      ? Colors.grey.shade600
                                      : null),
                            ),
                          );
                        }
                      },
                    ),

                    // Obx(
                    //   () => CommonDropdown(
                    //     hint: 'Select Customer',
                    //     selectedValue: addshipController.selectedCustomer.value,
                    //     onChanged: (newValue) {
                    //       addshipController.setSelectedCustomer(
                    //           newValue); // Update selection
                    //     },
                    //     items: addshipController.customerList
                    //         .map((customer) => DropdownMenuItem(
                    //               value:
                    //                   customer, // Pass the whole customer object
                    //               child: Text(customer.customers.toString() ??
                    //                   "Unknown Customer"), // Display customer name
                    //             ))
                    //         .toList(),
                    //   ),
                    // ),
                    dropdownText('Shipment Charges'),
                    CommonTextfiled(
                      keyboardType: TextInputType.number,
                      hintTxt: 'Shipment Charges',
                      controller: addshipController.shipmentChargeController,
                      onChanged: (value) {},
                    ),
                    dropdownText('Insurance Charges'),
                    CommonTextfiled(
                      keyboardType: TextInputType.number,
                      hintTxt: 'Insurance Charges',
                      controller: addshipController.insuranceChargeController,
                      onChanged: (value) {},
                    ),
                    dropdownText('ODA Charges'),
                    CommonTextfiled(
                      keyboardType: TextInputType.number,
                      hintTxt: 'ODA Charges',
                      controller: addshipController.odaChargeController,
                      onChanged: (value) {},
                    ),
                    dropdownText('Holiday Charges'),
                    CommonTextfiled(
                      keyboardType: TextInputType.number,
                      hintTxt: 'Holiday Charges',
                      controller: addshipController.holidayChargeController,
                    ),
                    dropdownText('Handling Charges'),
                    CommonTextfiled(
                      keyboardType: TextInputType.number,
                      hintTxt: 'Handling Charges',
                      controller: addshipController.headlingChargeController,
                      onChanged: (value) {},
                    ),
                    dropdownText('Total Charges'),
                    CommonTextfiled(
                      hintTxt: 'Total Charges',
                      controller: addshipController.totalChargeController,
                      isEnable: false,
                    ),
                    dropdownText(
                      'GST 18%',
                    ),
                    CommonTextfiled(
                      hintTxt: 'Grand Total',
                      controller: addshipController.gstChargeController,
                      isEnable: false,
                    ),
                    dropdownText(
                      'Docket No',
                    ),
                    CommonTextfiled(
                      hintTxt: 'Docket No',
                      controller: addshipController.docketNoController,
                      isEnable: true,
                    ),
                    Text('Total Amount (Including GST)',
                        style: themes.fontSize14_500),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
