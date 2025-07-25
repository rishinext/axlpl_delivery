import 'dart:io';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/cupertino.dart';
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
  if (Platform.isIOS) {
    // iOS Cupertino Dialog
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(subTitle),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction:
                  textCancel.toLowerCase().contains('delete') ||
                      textCancel.toLowerCase().contains('remove') ||
                      textCancel.toLowerCase().contains('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(textCancel),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text(textConfirm),
            ),
          ],
        );
      },
    );
  } else {
    // Android Material Dialog
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
}
