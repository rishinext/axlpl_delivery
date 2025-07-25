import 'dart:io';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showChangePasswordDialog() {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileController());

  if (Platform.isIOS) {
    // iOS Cupertino Dialog
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Change Password"),
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextField(
                    controller: controller.oldPasswordController,
                    obscureText: true,
                    placeholder: "Old Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                  ),
                  const SizedBox(height: 12),
                  CupertinoTextField(
                    controller: controller.newPasswordController,
                    obscureText: true,
                    placeholder: "New Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                  ),
                  const SizedBox(height: 12),
                  CupertinoTextField(
                    controller: controller.confirmPasswordController,
                    obscureText: true,
                    placeholder: "Confirm Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                // Validate form manually for Cupertino
                bool isValid = true;
                String errorMessage = '';

                if (controller.oldPasswordController.text.isEmpty) {
                  isValid = false;
                  errorMessage = 'Old password is required';
                } else if (controller.newPasswordController.text.length < 6) {
                  isValid = false;
                  errorMessage = 'New password must be at least 6 characters';
                } else if (controller.confirmPasswordController.text.isEmpty) {
                  isValid = false;
                  errorMessage = 'Confirm password is required';
                } else if (controller.newPasswordController.text !=
                    controller.confirmPasswordController.text) {
                  isValid = false;
                  errorMessage = 'Passwords do not match';
                }

                if (isValid) {
                  Navigator.of(context).pop();
                  controller.changePassword();
                } else {
                  // Show Cupertino error dialog
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text("Error"),
                      content: Text(errorMessage),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text("Change"),
            ),
          ],
        );
      },
    );
  } else {
    // Android Material Dialog
    Get.defaultDialog(
      title: "Change Password",
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller.oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Old Password"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
                validator: (value) => value == null || value.length < 6
                    ? "Min 6 characters"
                    : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Confirm Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Required";
                  if (value != controller.newPasswordController.text)
                    return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      radius: 10,
      textConfirm: "Change",
      textCancel: "Cancel",
      confirmTextColor: themes.whiteColor,
      buttonColor: themes.darkCyanBlue,
      onConfirm: () {
        if (_formKey.currentState?.validate() == true) {
          controller.changePassword();
        }
      },
    );
  }
}
