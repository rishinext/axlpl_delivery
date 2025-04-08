import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showChangePasswordDialog(
    BuildContext context, Function(String oldPass, String newPass) onSubmit) {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Get.defaultDialog(
    title: "Change Password",
    content: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: oldPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Old Password"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: newPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
              validator: (value) =>
                  value == null || value.length < 6 ? "Min 6 characters" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: confirmPassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
              validator: (value) {
                if (value == null || value.isEmpty) return "Required";
                if (value != newPassController.text)
                  return "Passwords do not match";
                return null;
              },
            ),
          ],
        ),
      ),
    ),
    radius: 10,
    textConfirm: "Submit",
    textCancel: "Cancel",
    confirmTextColor: themes.whiteColor,
    onConfirm: () {
      if (_formKey.currentState?.validate() == true) {
        Get.back(); // close dialog
        onSubmit(oldPassController.text, newPassController.text);
      }
    },
  );
}
