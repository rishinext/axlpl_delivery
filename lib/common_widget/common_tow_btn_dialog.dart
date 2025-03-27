import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void commonDialog(
  final title,
  final subTitle,
  final textConfirm,
  final textCancel,
  VoidCallback onConfirm,
) {
  Get.defaultDialog(
    titlePadding: EdgeInsets.only(top: 20), // Padding for title
    contentPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 25,
    ),
    title: title,
    middleText: subTitle,
    textConfirm: textConfirm,
    buttonColor: Themes().darkCyanBlue,
    textCancel: textCancel,
    onConfirm: onConfirm,
    onCancel: () {},
  );
}
