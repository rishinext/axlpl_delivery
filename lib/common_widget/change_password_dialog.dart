import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showChangePasswordDialog() {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileController());
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
              validator: (value) =>
                  value == null || value.length < 6 ? "Min 6 characters" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
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
