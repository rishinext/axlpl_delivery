import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/modules/add_shipment/controllers/add_shipment_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AddDifferentAddressView extends GetView {
  const AddDifferentAddressView({super.key});
  @override
  Widget build(BuildContext context) {
    final addshipController = Get.put(AddShipmentController());
    final Utils utils = Utils();
    return CommonScaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  dropdownText('Diffrent Delivery Address'),
                  Radio(
                    value: 0,
                    groupValue: addshipController.diffrentAddressType.value,
                    activeColor: themes.grayColor,
                    onChanged: (value) {
                      addshipController.diffrentAddressType.value = value!;
                    },
                  ),
                  Text("NO"),
                  Radio(
                    value: 1,
                    groupValue: addshipController.diffrentAddressType.value,
                    activeColor: themes.darkCyanBlue,
                    onChanged: (value) {
                      addshipController.diffrentAddressType.value = value!;
                    },
                  ),
                  Text("YES"),
                ],
              ),
              addshipController.diffrentAddressType.value == 1
                  ? Container(
                      decoration: BoxDecoration(
                          color: themes.whiteColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            dropdownText(zip),
                            CommonTextfiled(
                              // maxLength: 6,
                              hintTxt: zip,
                              controller:
                                  addshipController.diffrentZipController,
                              textInputAction: TextInputAction.next,
                              validator: utils.validateIndianZipcode,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value?.length == 6) {
                                  addshipController
                                      .fetchPincodeDetailsDiff(value!);
                                  addshipController
                                      .fetchAeraByZipDataDiff(value);
                                } else {
                                  // Optional: clear state/city if length < 6 again
                                  addshipController.pincodeDataDiff.value =
                                      null;
                                }
                                return null;
                              },
                            ),
                            dropdownText(state),
                            Obx(() {
                              final isLoading =
                                  addshipController.isLoadingDiffPincode.value;
                              final data =
                                  addshipController.pincodeDataDiff.value;
                              final error =
                                  addshipController.errorMessage.value;

                              if (isLoading) {
                                Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              }

                              return CommonTextfiled(
                                isEnable: false,
                                hintTxt: data?.stateName ??
                                    (error.isNotEmpty ? error : 'State'),
                                textInputAction: TextInputAction.next,
                                // validator: utils.validateText,
                              );
                            }),
                            dropdownText(city),
                            Obx(() {
                              final isLoading =
                                  addshipController.isLoadingDiffPincode.value;
                              final data =
                                  addshipController.pincodeDataDiff.value;
                              final error =
                                  addshipController.errorMessage.value;

                              addshipController.selectedDiffStateId.value =
                                  int.tryParse(data?.stateId ?? '0') ?? 0;
                              addshipController.selectedDiffCityId.value =
                                  int.tryParse(data?.cityId ?? '0') ?? 0;
                              addshipController.selectedDiffAreaId.value =
                                  int.tryParse(
                                        data?.areaId ?? '0',
                                      ) ??
                                      0;

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
                                // validator: utils.validateText,
                              );
                            }),
                            dropdownText('Area'),
                            Obx(
                              () => CommonDropdown<AreaList>(
                                hint: 'Select Area',
                                selectedValue: addshipController
                                    .selectedDiffrentArea.value,
                                isLoading:
                                    addshipController.isLoadingDiffArea.value,
                                items: addshipController.areaListDiff,
                                itemLabel: (c) => c.name ?? 'Unknown',
                                itemValue: (c) => c.id.toString(),
                                onChanged: (value) {
                                  if (value != null) {
                                    addshipController
                                        .selectedDiffrentArea.value = value;
                                  }
                                },
                              ),
                            ),
                            dropdownText('Address Line 1'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 1',
                              controller:
                                  addshipController.diffrentAddress1Controller,
                              textInputAction: TextInputAction.next,
                              validator: utils.validateText,
                            ),
                            dropdownText('Address Line 2'),
                            CommonTextfiled(
                              hintTxt: 'Address Line 2',
                              controller:
                                  addshipController.diffrentAddress2Controller,
                              textInputAction: TextInputAction.done,
                              validator: utils.validateText,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          );
        }),
      ),
    );
  }
}
