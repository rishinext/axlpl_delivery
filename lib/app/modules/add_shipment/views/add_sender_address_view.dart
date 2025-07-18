import 'dart:developer';

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
import 'package:get/get_connect/http/src/utils/utils.dart';

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
                    () => Radio(
                      value: 0,
                      groupValue: addshipController.senderAddressType.value,
                      activeColor: themes.orangeColor,
                      onChanged: (value) {
                        addshipController.senderAddressType.value = value!;
                        log(value.toString());
                      },
                    ),
                  ),
                  Text("New Address"),
                  Obx(() {
                    return Radio(
                      value: 1,
                      groupValue: addshipController.senderAddressType.value,
                      activeColor: themes.grayColor,
                      onChanged: (value) {
                        addshipController.senderAddressType.value = value!;
                        log(addshipController.senderAddressType.value
                            .toString());
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
                    if (addshipController.senderAddressType.value == 1) {
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

                              addshipController.selectedExistingSenderStateId
                                  .value = int.tryParse(
                                      selectedCustomer.stateId ?? '0') ??
                                  0;
                              addshipController.selectedExistingSenderCityId
                                  .value = int.tryParse(
                                      selectedCustomer.cityId ?? '0') ??
                                  0;
                              addshipController.selectedExistingSenderAreaId
                                  .value = int.tryParse(
                                      selectedCustomer.areaId ?? '0') ??
                                  0;
                              log(selectedCustomer.stateId.toString());
                              addshipController.existingSenderInfoNameController
                                  .text = selectedCustomer.fullName ?? '';
                              addshipController
                                  .existingSenderInfoCompanyNameController
                                  .text = selectedCustomer.companyName ?? '';
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
                          dropdownText('Customer Name'),
                          CommonTextfiled(
                            isEnable: false,
                            hintTxt: 'Customer Name',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoNameController,
                          ),
                          dropdownText('Company Name'),
                          CommonTextfiled(
                            isEnable: false,
                            hintTxt: 'Company Name',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateText,
                            controller: addshipController
                                .existingSenderInfoCompanyNameController,
                          ),
                          dropdownText(zip),
                          CommonTextfiled(
                            isEnable: false,
                            hintTxt: zip,
                            controller: addshipController
                                .existingSenderInfoZipController,
                            textInputAction: TextInputAction.next,
                            validator: utils.validateIndianZipcode,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value?.length == 6) {
                                addshipController
                                    .fetchPincodeDetailsSenderInfo(value!);
                                addshipController.fetchSenderAreaByZip(value);
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
                                addshipController.isLoadingSenderArea.value;
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
                            validator: utils.validateGST,
                            controller: addshipController
                                .existingSenderInfoGstNoController,
                            maxLength: 15,
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
                          //new sender addresss
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
                            validator: utils.validateIndianZipcode,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value?.length == 6) {
                                addshipController
                                    .fetchPincodeDetailsSenderInfo(value!);
                                addshipController.fetchSenderAreaByZip(value);
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
                            log("state id : => ${data?.stateId.toString()}" ??
                                'N/A');
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
                          //new sender address
                          Obx(() {
                            final isLoading =
                                addshipController.isLoadingPincode.value;
                            final data =
                                addshipController.pincodeDetailsData.value;
                            final error = addshipController.errorMessage.value;
                            log(data?.cityId.toString() ?? 'N/A');

                            if (isLoading) {
                              Center(
                                  child: CircularProgressIndicator.adaptive());
                            }
                            addshipController.selectedSenderStateId.value =
                                int.tryParse(data?.stateId ?? '0') ?? 0;
                            addshipController.selectedSenderCityId.value =
                                int.tryParse(data?.cityId ?? '0') ?? 0;
                            addshipController.selectedSenderAreaId.value =
                                int.tryParse(
                                      data?.areaId ?? '0',
                                    ) ??
                                    0;
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
                                    addshipController.selectedSenderArea.value,
                                isLoading:
                                    addshipController.isLoadingSenderArea.value,
                                items: addshipController.senderAreaList,
                                itemLabel: (c) => c.name ?? 'Unknown',
                                itemValue: (c) => c.id.toString(),
                                onChanged: (val) => addshipController
                                    .selectedSenderArea.value = val,
                              )),
                          dropdownText('GST No'),
                          CommonTextfiled(
                            hintTxt: 'GST No',
                            textInputAction: TextInputAction.next,
                            validator: utils.validateGST,
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
                            maxLength: 10,
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
                            validator: utils.validateEmail,
                            controller:
                                addshipController.senderInfoEmailController,
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
