import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  final formKey = GlobalKey<FormState>();

  RxBool isObsecureText = true.obs;

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? validatePhoneNumber(String? value) {
    final phoneRegex = RegExp(r'^\+91[0-9]{10}$'); // +91 followed by 10 digits
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
