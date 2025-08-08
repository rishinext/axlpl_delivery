import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/paginated_dropdown.dart';
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
                      //existing address
                      return Column(
                        spacing: 5.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => PaginatedDropdown<CustomersList>(
                                hint: 'Select Customer',
                                selectedValue: addshipController
                                            .selectedExitingCustomer.value !=
                                        null
                                    ? addshipController.customerList
                                        .firstWhereOrNull(
                                        (e) =>
                                            e.id ==
                                            addshipController
                                                .selectedExitingCustomer.value,
                                      )
                                    : null,
                                items: addshipController.customerList,
                                itemLabel: (customer) =>
                                    customer.companyName ?? 'Unknown',
                                itemValue: (customer) => customer.id,
                                isLoading:
                                    addshipController.isLoadingCustomers.value,
                                isLoadingMore: addshipController
                                    .isLoadingMoreCustomers.value,
                                hasMoreData:
                                    addshipController.hasMoreCustomers.value,
                                onLoadMore: () async {
                                  await addshipController.loadMoreCustomers();
                                },
                                onChanged: (CustomersList? customer) {
                                  if (customer != null) {
                                    addshipController.selectedExitingCustomer
                                        .value = customer.id;

                                    addshipController
                                            .selectedExistingSenderStateId
                                            .value =
                                        int.tryParse(customer.stateId ?? '0') ??
                                            0;
                                    addshipController
                                            .selectedExistingSenderCityId
                                            .value =
                                        int.tryParse(customer.cityId ?? '0') ??
                                            0;
                                    addshipController
                                            .selectedExistingSenderAreaId
                                            .value =
                                        int.tryParse(customer.areaId ?? '0') ??
                                            0;

                                    log(customer.stateId.toString());
                                    addshipController
                                        .existingSenderInfoNameController
                                        .text = customer.fullName ?? '';
                                    addshipController
                                        .existingSenderInfoCompanyNameController
                                        .text = customer.companyName ?? '';
                                    addshipController
                                        .existingSenderInfoZipController
                                        .text = customer.pincode ?? '';
                                    addshipController
                                        .existingSenderInfoStateController
                                        .text = customer.stateName ?? '';
                                    addshipController
                                        .existingSenderInfoCityController
                                        .text = customer.cityName ?? '';
                                    addshipController
                                        .existingSenderInfoMobileController
                                        .text = customer.mobileNo ?? '';
                                    addshipController
                                        .existingSenderInfoEmailController
                                        .text = customer.email ?? '';
                                    addshipController
                                        .existingSenderInfoAddress1Controller
                                        .text = customer.address1 ?? '';
                                    addshipController
                                        .existingSenderInfoAddress2Controller
                                        .text = customer.address2 ?? '';
                                    addshipController
                                        .existingSenderInfoGstNoController
                                        .text = customer.gstNo ?? '';
                                    addshipController
                                        .existingSenderInfoAreaController
                                        .text = customer.areaName ?? '';
                                  }
                                },
                              )),
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
                            log("state id : => ${data?.stateId.toString() ?? 'N/A'}");
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
