import 'dart:io';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void commonDialog(
  final title,
  final subTitle,
  final textConfirm,
  final textCancel,
  VoidCallback onConfirm, {
  IconData? icon,
  Color? iconColor,
}) {
  if (Platform.isIOS) {
    // iOS Cupertino Dialog
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              subTitle,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
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
    // Android Material Dialog with icon support
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? Themes().darkCyanBlue,
                  size: 24,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            subTitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Themes().darkCyanBlue, width: 1.5),
                foregroundColor: Themes().darkCyanBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(textCancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Themes().darkCyanBlue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(textConfirm),
            ),
          ],
        );
      },
    );
  }
}
