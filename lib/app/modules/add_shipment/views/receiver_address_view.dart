import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/controllers/add_shipment_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ReceiverAddressView extends GetView {
  const ReceiverAddressView({super.key});
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
                dropdownText('Receiver Info'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Radio(
                        value: 0,
                        groupValue:
                            addshipController.receviverAddressType.value,
                        activeColor: themes.orangeColor,
                        onChanged: (value) {
                          addshipController.receviverAddressType.value = value!;
                        },
                      ),
                    ),
                    Text("New Address"),
                    Obx(() {
                      return Radio(
                        value: 1,
                        groupValue:
                            addshipController.receviverAddressType.value,
                        activeColor: themes.grayColor,
                        onChanged: (value) {
                          addshipController.receviverAddressType.value = value!;
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
                      if (addshipController.receviverAddressType.value == 1) {
                        //ext add
                        return Column(
                          spacing: 5.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //existing receiver
                            CommonDropdown<String>(
                              isSearchable: true,
                              hint: 'Select Customer',
                              selectedValue: addshipController
                                  .selectedReceiverCustomer.value,
                              isLoading: addshipController
                                  .isLoadingReceiverCustomer.value,

                              // Use customerReceiverList here, not receiverAreaList
                              items: addshipController.customerReceiverList
                                  .map((e) => e.id!)
                                  .toList(),

                              itemLabel: (id) {
                                final customer = addshipController
                                    .customerReceiverList
                                    .firstWhere(
                                  (e) => e.id == id,
                                  orElse: () =>
                                      CustomersList(), // Or provide a default customer object
                                );
                                return customer.companyName ?? 'Unknown';
                              },

                              itemValue: (id) => id,

                              onChanged: (id) {
                                addshipController
                                    .selectedReceiverCustomer.value = id;

                                final selectedCustomer = addshipController
                                    .customerReceiverList
                                    .firstWhere(
                                  (e) => e.id == id,
                                  orElse: () => CustomersList(),
                                );

                                addshipController
                                    .selectedExistingReceiverStateId
                                    .value = int.tryParse(
                                        selectedCustomer.stateId ?? '0') ??
                                    0;
                                addshipController.selectedExistingReceiverCityId
                                    .value = int.tryParse(
                                        selectedCustomer.cityId ?? '0') ??
                                    0;
                                addshipController.selectedExistingReceiverAreaId
                                    .value = int.tryParse(
                                        selectedCustomer.areaId ?? '0') ??
                                    0;

                                addshipController.receiverExistingNameController
                                    .text = selectedCustomer.fullName ?? '';
                                addshipController
                                    .receiverExistingCompanyNameController
                                    .text = selectedCustomer.companyName ?? '';
                                addshipController.receiverExistingZipController
                                    .text = selectedCustomer.pincode ?? '';
                                addshipController
                                    .receiverExistingStateController
                                    .text = selectedCustomer.stateName ?? '';
                                addshipController.receiverExistingCityController
                                    .text = selectedCustomer.cityName ?? '';
                                addshipController
                                    .receiverExistingMobileController
                                    .text = selectedCustomer.mobileNo ?? '';
                                addshipController
                                    .receiverExistingEmailController
                                    .text = selectedCustomer.email ?? '';
                                addshipController
                                    .receiverExistingAddress1Controller
                                    .text = selectedCustomer.address1 ?? '';
                                addshipController
                                    .receiverExistingAddress2Controller
                                    .text = selectedCustomer.address2 ?? '';
                                addshipController
                                    .receiverExistingGstNoController
                                    .text = selectedCustomer.gstNo ?? '';
                                addshipController.receiverExistingAreaController
                                    .text = selectedCustomer.areaName ?? '';
                              },
                            ),
                            dropdownText('Name'),
                            CommonTextfiled(
                              isEnable: false,
                              hintTxt: 'Name',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingNameController,
                            ),
                            dropdownText('Company Name'),
                            CommonTextfiled(
                              isEnable: false,
                              hintTxt: 'Company Name',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingCompanyNameController,
                            ),
                            dropdownText(zip),
                            CommonTextfiled(
                              hintTxt: zip,
                              controller: addshipController
                                  .receiverExistingZipController,
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value?.length == 6) {
                                  addshipController
                                      .fetchPincodeDetailsReceiverInfo(value!);
                                  addshipController
                                      .fetchReceiverAreaByZip(value);
                                } else {
                                  // Optional: clear state/city if length < 6 again
                                  addshipController
                                      .pincodeReceiverDetailsData.value = null;
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
                                  .receiverExistingStateController,
                            ),
                            dropdownText(city),
                            Obx(() {
                              final isLoading = addshipController
                                  .isLoadingReceiverPincode.value;
                              final data = addshipController
                                  .pincodeReceiverDetailsData.value;
                              final error =
                                  addshipController.errorMessage.value;

                              if (isLoading) {
                                Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }

                              return CommonTextfiled(
                                isEnable: false,
                                hintTxt: data?.cityName ??
                                    (error.isNotEmpty ? error : 'City'),
                                textInputAction: TextInputAction.next,
                                controller: addshipController
                                    .receiverExistingCityController,
                              );
                            }),
                            dropdownText('Select Aera'),
                            CommonTextfiled(
                              isEnable: false,
                              hintTxt: 'Area',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingAreaController,
                            ),
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
                                  .receiverExistingGstNoController,
                            ),
                            dropdownText('Address Line 1'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 1',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingAddress1Controller,
                            ),
                            dropdownText('Address Line 2'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 2',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingAddress2Controller,
                            ),
                            dropdownText('Mobile'),
                            CommonTextfiled(
                              hintTxt: 'Mobile',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              validator: utils.validatePhone,
                              controller: addshipController
                                  .receiverExistingMobileController,
                            ),
                            dropdownText("Email"),
                            CommonTextfiled(
                              hintTxt: 'Email',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverExistingEmailController,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dropdownText('Company Name'),
                            CommonTextfiled(
                              hintTxt: 'Company Name',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverInfoCompanyNameController,
                            ),
                            dropdownText(zip),
                            CommonTextfiled(
                              isEnable: false,
                              hintTxt: zip,
                              controller:
                                  addshipController.receiverInfoZipController,
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value?.length == 6) {
                                  addshipController
                                      .fetchPincodeDetailsReceiverInfo(value!);
                                  addshipController
                                      .fetchReceiverAreaByZip(value);
                                } else {
                                  // Optional: clear state/city if length < 6 again
                                  addshipController
                                      .pincodeReceiverDetailsData.value = null;
                                }
                                return null;
                              },
                            ),
                            dropdownText(state),
                            Obx(() {
                              final isLoading = addshipController
                                  .isLoadingReceiverPincode.value;
                              final data = addshipController
                                  .pincodeReceiverDetailsData.value;
                              final error =
                                  addshipController.errorMessage.value;

                              if (isLoading) {
                                Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }
                              addshipController.selectedReceiverStateId.value =
                                  int.tryParse(data?.stateId ?? '0') ?? 0;
                              addshipController.selectedReceiverCityId.value =
                                  int.tryParse(data?.cityId ?? '0') ?? 0;
                              addshipController.selectedReceiverAreaId.value =
                                  int.tryParse(data?.areaId ?? '0') ?? 0;
                              return CommonTextfiled(
                                isEnable: false,
                                hintTxt: data?.stateName ??
                                    (error.isNotEmpty ? error : 'State'),
                                textInputAction: TextInputAction.next,
                                controller: addshipController
                                    .receiverInfoStateController,
                              );
                            }),
                            dropdownText(city),
                            Obx(() {
                              final isLoading = addshipController
                                  .isLoadingReceiverPincode.value;
                              final data = addshipController
                                  .pincodeReceiverDetailsData.value;
                              final error =
                                  addshipController.errorMessage.value;

                              if (isLoading) {
                                Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }

                              return CommonTextfiled(
                                isEnable: false,
                                hintTxt: data?.cityName ??
                                    (error.isNotEmpty ? error : 'City'),
                                textInputAction: TextInputAction.next,
                                controller: addshipController
                                    .receiverInfoCityController,
                              );
                            }),
                            dropdownText('Select Aera'),
                            Obx(() => CommonDropdown<AreaList>(
                                  hint: 'Select Area',
                                  selectedValue: addshipController
                                      .selectedReceiverArea.value,
                                  isLoading: addshipController
                                      .isLoadingReceiverArea.value,
                                  items: addshipController.receiverAreaList,
                                  itemLabel: (c) => c.name ?? 'Unknown',
                                  itemValue: (c) => c.id.toString(),
                                  onChanged: (val) => addshipController
                                      .selectedReceiverArea.value = val,
                                )),
                            dropdownText('GST No'),
                            CommonTextfiled(
                              hintTxt: 'GST No',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller:
                                  addshipController.receiverInfoGstNoController,
                            ),
                            dropdownText('Address Line 1'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 1',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverInfoAddress1Controller,
                            ),
                            dropdownText('Address Line 2'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 2',
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                              controller: addshipController
                                  .receiverInfoAddress2Controller,
                            ),
                            dropdownText('Mobile'),
                            CommonTextfiled(
                              hintTxt: 'Mobile',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              validator: utils.validatePhone,
                              controller: addshipController
                                  .receiverInfoMobileController,
                            ),
                            dropdownText("Email"),
                            CommonTextfiled(
                              hintTxt: 'Email',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              validator: utils.validateText,
                              controller:
                                  addshipController.receiverInfoEmailController,
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
      ),
    );
  }
}
