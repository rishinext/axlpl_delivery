import 'dart:developer';

import 'package:axlpl_delivery/app/modules/add_shipment/controllers/add_shipment_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AddPaymentInfoView extends GetView {
  const AddPaymentInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
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

                    dropdownText('Sub Payment Info'),
                    Obx(() => CommonDropdown<Map>(
                          hint: 'Select Payment',
                          selectedValue:
                              addshipController.selectedSubPaymentId.value,
                          isLoading: false,
                          items: addshipController.subPaymentModes,
                          itemLabel: (m) => m['name'] ?? '',
                          itemValue: (m) => m['id'],
                          onChanged: (val) {
                            log(val.toString());
                            addshipController.selectedPaymentModeId.value = val;
                          },
                        )),
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
                      hintTxt: 'Shipment Charges',
                      controller: addshipController.shipmentChargeController,
                      onChanged: (value) {
                        addshipController.calculateGST();
                      },
                    ),
                    dropdownText('Insurance Charges'),
                    CommonTextfiled(
                      hintTxt: 'Insurance Charges',
                      controller: addshipController.insuranceChargeController,
                      onChanged: (value) {
                        addshipController.calculateGST();
                      },
                    ),
                    dropdownText('ODA Charges'),
                    CommonTextfiled(
                      hintTxt: 'ODA Charges',
                      controller: addshipController.odaChargeController,
                      onChanged: (value) {
                        addshipController.calculateGST();
                      },
                    ),
                    dropdownText('Holiday Charges'),
                    CommonTextfiled(
                      hintTxt: 'Holiday Charges',
                      controller: addshipController.holidayChargeController,
                    ),
                    dropdownText('Handling Charges'),
                    CommonTextfiled(
                      hintTxt: 'Handling Charges',
                      controller: addshipController.headlingChargeController,
                      onChanged: (value) {
                        addshipController.calculateGST();
                      },
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
