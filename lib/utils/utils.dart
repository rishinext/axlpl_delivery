import 'package:axlpl_delivery/utils/theme.dart';

Themes themes = Themes();

String? validatePhone(String? value) {
  // Regex for phone number validation (example for US numbers)
  final RegExp phoneExp = RegExp(r'^\+?[1-9]\d{1,14}$');
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  } else if (!phoneExp.hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null;
}

String? validateEmail(String? value) {
  // Regex for phone number validation (example for US numbers)
  final RegExp emailExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty) {
    return 'Email ID is required';
  } else if (!emailExp.hasMatch(value)) {
    return 'Enter a valid Email ID';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

String? validateText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Value is required';
  }
  return null;
}
