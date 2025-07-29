import 'dart:io';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showChangePasswordDialog() {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ProfileController>();

  // Create local controllers to avoid disposal issues
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void disposeControllers() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  if (Platform.isIOS) {
    // iOS Cupertino Dialog
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Change Password"),
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoTextField(
                    controller: oldPasswordController,
                    obscureText: true,
                    placeholder: "Old Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                  ),
                  const SizedBox(height: 12),
                  CupertinoTextField(
                    controller: newPasswordController,
                    obscureText: true,
                    placeholder: "New Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                  ),
                  const SizedBox(height: 12),
                  CupertinoTextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    placeholder: "Confirm Password",
                    decoration: BoxDecoration(
                      border: Border.all(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                disposeControllers();
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                // Validate form manually for Cupertino
                bool isValid = true;
                String errorMessage = '';

                if (oldPasswordController.text.isEmpty) {
                  isValid = false;
                  errorMessage = 'Old password is required';
                } else if (newPasswordController.text.length < 6) {
                  isValid = false;
                  errorMessage = 'New password must be at least 6 characters';
                } else if (confirmPasswordController.text.isEmpty) {
                  isValid = false;
                  errorMessage = 'Confirm password is required';
                } else if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  isValid = false;
                  errorMessage = 'Passwords do not match';
                }

                if (isValid) {
                  // Set the values to the controller's text controllers before calling changePassword
                  controller.oldPasswordController.text =
                      oldPasswordController.text;
                  controller.newPasswordController.text =
                      newPasswordController.text;
                  controller.confirmPasswordController.text =
                      confirmPasswordController.text;

                  disposeControllers();
                  Navigator.of(context).pop();
                  controller.changePassword();
                } else {
                  // Show Cupertino error dialog
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Error"),
                      content: Text(errorMessage),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text("Change"),
            ),
          ],
        );
      },
    ).then((_) {
      // Ensure controllers are disposed if dialog is dismissed by other means
      try {
        disposeControllers();
      } catch (e) {
        // Controllers might already be disposed, ignore the error
      }
    });
  } else {
    // Android Material Dialog with proper size constraints
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: SizedBox(
            width: double.minPositive,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Old Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "New Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.length < 6
                        ? "Min 6 characters"
                        : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Required";
                      if (value != newPasswordController.text)
                        return "Passwords do not match";
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                disposeControllers();
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: themes.darkCyanBlue, width: 1.5),
                foregroundColor: themes.darkCyanBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  // Set the values to the controller's text controllers before calling changePassword
                  controller.oldPasswordController.text =
                      oldPasswordController.text;
                  controller.newPasswordController.text =
                      newPasswordController.text;
                  controller.confirmPasswordController.text =
                      confirmPasswordController.text;

                  disposeControllers();
                  Navigator.of(context).pop();
                  controller.changePassword();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themes.darkCyanBlue,
                foregroundColor: themes.whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text("Change"),
            ),
          ],
        );
      },
    ).then((_) {
      // This will be called when the dialog is dismissed by any means
      // But we need to ensure controllers aren't already disposed
      try {
        disposeControllers();
      } catch (e) {
        // Controllers might already be disposed, ignore the error
      }
    });
  }
}
