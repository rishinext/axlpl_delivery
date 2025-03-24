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
                    ),
                    dropdownText('Insurance Charges'),
                    CommonTextfiled(
                      hintTxt: 'Insurance Charges',
                    ),
                    dropdownText('ODA Charges'),
                    CommonTextfiled(
                      hintTxt: 'ODA Charges',
                    ),
                    dropdownText('Holiday Charges'),
                    CommonTextfiled(
                      hintTxt: 'Holiday Charges',
                    ),
                    dropdownText('Handling Charges'),
                    CommonTextfiled(
                      hintTxt: 'Address Line 1',
                    ),
                    dropdownText('Total Charges'),
                    CommonTextfiled(
                      hintTxt: 'Total Charges',
                    ),
                    dropdownText('GST 18%'),
                    CommonTextfiled(
                      hintTxt: 'GST',
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
