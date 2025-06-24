import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
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
    // final data = addshipController.shipmentData;

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
                      value: "1",
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
                      value: "2",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (addshipController.addressType.value == "2") {
                      //ext add
                      return Column(
                        spacing: 5.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonDropdown<String>(
                            isSearchable: true,
                            hint: 'Select Customer',
                            selectedValue:
                                addshipController.selectedExitingCustomer.value,
                            isLoading:
                                addshipController.isLoadingCustomers.value,

                            // Dropdown items from customer IDs
                            items: addshipController.customerList
                                .map((e) => e.id!)
                                .toList(),

                            // Display company name from ID
                            itemLabel: (id) {
                              final customer =
                                  addshipController.customerList.firstWhere(
                                (e) => e.id == id,
                                orElse: () => CustomersList(),
                              );
                              return customer.companyName ?? 'Unknown';
                            },

                            itemValue: (id) => id,

                            onChanged: (id) {
                              addshipController.selectedExitingCustomer.value =
                                  id;

                              final selectedCustomer =
                                  addshipController.customerList.firstWhere(
                                (e) => e.id == id,
                                orElse: () => CustomersList(),
                              );
                              addshipController.existingSenderInfoZipController
                                  .text = selectedCustomer.pincode ?? '';
                              addshipController
                                  .existingSenderInfoStateController
                                  .text = selectedCustomer.stateName ?? '';
                              addshipController.existingSenderInfoCityController
                                  .text = selectedCustomer.cityName ?? '';
                              addshipController
                                  .existingSenderInfoMobileController
                                  .text = selectedCustomer.mobileNo ?? '';
                              addshipController
                                  .existingSenderInfoEmailController
                                  .text = selectedCustomer.email ?? '';
                              addshipController
                                  .existingSenderInfoAddress1Controller
                                  .text = selectedCustomer.address1 ?? '';
                              addshipController
                                  .existingSenderInfoAddress2Controller
                                  .text = selectedCustomer.address2 ?? '';
                              addshipController
                                  .existingSenderInfoGstNoController
                                  .text = selectedCustomer.gstNo ?? '';
                              addshipController.existingSenderInfoAreaController
                                  .text = selectedCustomer.areaName ?? '';
                              // addshipController.fetchAeraByZipData(
                              //   addshipController
                              //       .existingSenderInfoZipController.text,
                              // );
                            },
                          ),
                          dropdownText(zip),
                          CommonTextfiled(
                            hintTxt: zip,
                            controller: addshipController
                                .existingSenderInfoZipController,
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value?.length == 6) {
                                addshipController
                                    .fetchPincodeDetailsSenderInfo(value!);
                                addshipController.fetchAeraByZipData(value);
                              } else {
                                // Optional: clear state/city if length < 6 again
                                addshipController.pincodeDetailsData.value =
                                    null;
                              }
                              return null;
                            },
                          ),
                          dropdownText(state),
                          CommonTextfiled(
                            isEnable: false,
                            hintTxt: 'state',
                            textInputAction: TextInputAction.next,
                            controller: addshipController
                                .existingSenderInfoStateController,
                          ),
                          dropdownText(city),
                          Obx(() {
                            final isLoading =
                                addshipController.isLoadingPincode.value;
                            final data =
                                addshipController.pincodeDetailsData.value;
                            final error = addshipController.errorMessage.value;

                            if (isLoading) {
                              Center(
                                  child: CircularProgressIndicator.adaptive());
                            }

                            return CommonTextfiled(
                              isEnable: false,
                              hintTxt: data?.cityName ??
                                  (error.isNotEmpty ? error : 'City'),
                              textInputAction: TextInputAction.next,
                              controller: addshipController
                                  .existingSenderInfoCityController,
                            );
                          }),
                          dropdownText('Select Aera'),
                          // CommonTextfiled(
                          //   isEnable: true,
                          //   hintTxt: 'Aera',
                          //   textInputAction: TextInputAction.next,
                          //   validator: utils.validateText,
                          //   controller: addshipController
                          //       .existingSenderInfoAreaController,
                          // ),
                          Obx(() {
                            final isLoading =
                                addshipController.isLoadingArea.value;
                            final data =
                                addshipController.areaDetailsData.value;
                            final error = addshipController.errorMessage.value;

                            if (isLoading) {
                              Center(
                                  child: CircularProgressIndicator.adaptive());
                            }

                            return CommonTextfiled(
                              isEnable: false,
                              hintTxt: data?.areaName ??
                                  (error.isNotEmpty ? error : 'Aera'),
                              textInputAction: TextInputAction.next,
                              controller: addshipController
                                  .existingSenderInfoAreaController,
                            );
                          }),
                          // Obx(() => CommonDropdown<AreaList>(
                          //       hint: 'Select Area',
                          //       selectedValue:
                          //           addshipController.selectedArea.value,
                          //       isLoading:
                          //           addshipController.isLoadingArea.value,
                          //       items: addshipController.areaList,
                          //       itemLabel: (c) => c.name ?? 'Unknown',
                          //       itemValue: (c) => c.id.toString(),
                          //       onChanged: (val) =>
                          //           addshipController.selectedArea.value = val,
                          //     )),
                          dropdownText('GST No'),
                          CommonTextfiled(
                            hintTxt: 'GST No',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoGstNoController,
                          ),
                          dropdownText('Address Line 1'),
                          CommonTextfiled(
                            hintTxt: 'Address Line 1',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoAddress1Controller,
                          ),
                          dropdownText('Address Line 2'),
                          CommonTextfiled(
                            hintTxt: 'Address Line 2',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoAddress2Controller,
                          ),
                          dropdownText('Mobile'),
                          CommonTextfiled(
                            hintTxt: 'Mobile',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            validator: utils.validatePhone,
                            controller: addshipController
                                .existingSenderInfoMobileController,
                          ),
                          dropdownText("Email"),
                          CommonTextfiled(
                            hintTxt: 'Email',
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoEmailController,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dropdownText('Customer Name'),
                          CommonTextfiled(
                            hintTxt: 'Customer Name',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller:
                                addshipController.senderInfoNameController,
                          ),
                          dropdownText('Company Name'),
                          CommonTextfiled(
                            hintTxt: 'Company Name',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .senderInfoCompanyNameController,
                          ),
                          dropdownText(zip),
                          CommonTextfiled(
                            hintTxt: zip,
                            controller:
                                addshipController.senderInfoZipController,
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value?.length == 6) {
                                addshipController
                                    .fetchPincodeDetailsSenderInfo(value!);
                                addshipController.fetchAeraByZipData(value);
                              } else {
                                // Optional: clear state/city if length < 6 again
                                addshipController.pincodeDetailsData.value =
                                    null;
                              }
                              return null;
                            },
                          ),
                          dropdownText(state),
                          Obx(() {
                            final isLoading =
                                addshipController.isLoadingPincode.value;
                            final data =
                                addshipController.pincodeDetailsData.value;
                            final error = addshipController.errorMessage.value;

                            if (isLoading) {
                              Center(
                                  child: CircularProgressIndicator.adaptive());
                            }

                            return CommonTextfiled(
                              isEnable: false,
                              hintTxt: data?.stateName ??
                                  (error.isNotEmpty ? error : 'State'),
                              textInputAction: TextInputAction.next,
                              controller:
                                  addshipController.senderInfoStateController,
                            );
                          }),
                          dropdownText(city),
                          Obx(() {
                            final isLoading =
                                addshipController.isLoadingPincode.value;
                            final data =
                                addshipController.pincodeDetailsData.value;
                            final error = addshipController.errorMessage.value;

                            if (isLoading) {
                              Center(
                                  child: CircularProgressIndicator.adaptive());
                            }

                            return CommonTextfiled(
                              isEnable: false,
                              hintTxt: data?.cityName ??
                                  (error.isNotEmpty ? error : 'City'),
                              textInputAction: TextInputAction.next,
                              controller:
                                  addshipController.senderInfoCityController,
                            );
                          }),
                          dropdownText('Select Aera'),
                          Obx(() => CommonDropdown<AreaList>(
                                hint: 'Select Area',
                                selectedValue:
                                    addshipController.selectedArea.value,
                                isLoading:
                                    addshipController.isLoadingArea.value,
                                items: addshipController.areaList,
                                itemLabel: (c) => c.name ?? 'Unknown',
                                itemValue: (c) => c.id.toString(),
                                onChanged: (val) =>
                                    addshipController.selectedArea.value = val,
                              )),
                          dropdownText('GST No'),
                          CommonTextfiled(
                            hintTxt: 'GST No',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller:
                                addshipController.senderInfoGstNoController,
                          ),
                          dropdownText('Address Line 1'),
                          CommonTextfiled(
                            hintTxt: 'Address Line 1',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller:
                                addshipController.senderInfoAddress1Controller,
                          ),
                          dropdownText('Address Line 2'),
                          CommonTextfiled(
                            hintTxt: 'Address Line 2',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller:
                                addshipController.senderInfoAddress2Controller,
                          ),
                          dropdownText('Mobile'),
                          CommonTextfiled(
                            hintTxt: 'Mobile',
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            validator: utils.validatePhone,
                            controller:
                                addshipController.senderInfoMobileController,
                          ),
                          dropdownText("Email"),
                          CommonTextfiled(
                            hintTxt: 'Email',
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            validator: utils.validateText,
                            controller: addshipController
                                .senderInfoExitingEmailController,
                          ),
                        ],
                      ); // hides the dropdown
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
