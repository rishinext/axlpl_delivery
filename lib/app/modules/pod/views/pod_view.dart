import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

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
              ContainerTextfiled(
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: themes.grayColor,
                ),
                suffixIcon: Icon(CupertinoIcons.qrcode_viewfinder),
                hintText: 'Shipment ID',
                controller: controller.searchController,
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: [8, 4],
                radius: Radius.circular(10.r),
                padding: EdgeInsets.all(2),
                color: themes.blueColor,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: themes.blueGray,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(38.0).r,
                    child: Column(
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
                    ),
                  ),
                ),
              ),
              CommonButton(
                title: 'Upload',
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
