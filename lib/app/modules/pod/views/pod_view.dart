import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/image_picker_widget.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controllers/pod_controller.dart';

class PodView extends GetView<PodController> {
  const PodView({super.key});
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBar: commonAppbar('Upload POD'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Column(
            spacing: 20,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ContainerTextfiled(
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: themes.grayColor,
                      ),
                      hintText: 'Shipment ID',
                      controller: controller.shipmentIdController,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      String? res = await SimpleBarcodeScanner.scanBarcode(
                        scanType: ScanType.defaultMode,
                        context,
                        barcodeAppBar: const BarcodeAppBar(
                          appBarTitle: '',
                          centerTitle: false,
                          enableBackButton: true,
                          backButtonIcon: Icon(Icons.arrow_back_ios),
                        ),
                        isShowFlashIcon: true,
                        cameraFace: CameraFace.back,
                      );

                      if (res != null && res != "-1") {
                        controller.shipmentIdController.text = res;
                        log("Scanned result: $res");
                      } else {
                        log("Scan cancelled or failed.");
                      }
                    },
                    icon: Icon(CupertinoIcons.qrcode_viewfinder),
                  )
                ],
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: [8, 4],
                radius: Radius.circular(10.r),
                padding: EdgeInsets.all(2),
                color: themes.blueColor,
                child: Obx(
                  () => InkWell(
                    onTap: () {
                      if (controller.shipmentIdController.text.isNotEmpty) {
                        pickImage(ImageSource.camera, controller.imageFile);
                      } else {
                        Get.snackbar(
                          'error',
                          'Shipment ID Required!',
                          colorText: themes.whiteColor,
                          backgroundColor: themes.redColor,
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: themes.blueGray,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(38.0).r,
                        child: controller.imageFile.value == null
                            ? Column(
                                children: [
                                  Image.asset(
                                    uploadIcon,
                                    width: 40.w,
                                  ),
                                  Text(
                                    'Upload your file here',
                                    style: themes.fontSize14_500,
                                  )
                                ],
                              )
                            : Image.file(
                                width: 50.w,
                                height: 100.h,
                                File(
                                  controller.imageFile.value!.path,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              controller.shipmentRecordList.any(
                (item) => item.paymentMode?.toLowerCase() == 'topay',
              )
                  ? Column(
                      children: [
                        dropdownText('Payment Mode'),
                        Obx(() => CommonDropdown<Map>(
                              hint: 'Select Payment',
                              selectedValue:
                                  controller.selectedPaymentModeId.value,
                              isLoading: false,
                              items: controller.paymentModes,
                              itemLabel: (m) => m['name'] ?? '',
                              itemValue: (m) => m['id'],
                              onChanged: (val) {
                                log(val.toString());
                                controller.selectedPaymentModeId.value = val;
                              },
                            )),
                      ],
                    )
                  : SizedBox.shrink(),
              CommonButton(
                title: 'Upload',
                onPressed: () async {
                  controller.uploadPod(
                    shipmentStatus: 'Delivered',
                    shipmentOtp: '0000',
                    file: File(
                      controller.imageFile.value?.path ?? '',
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
