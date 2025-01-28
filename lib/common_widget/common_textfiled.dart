import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommomTextfiled extends StatelessWidget {
  final textFieldFocusNode = FocusNode();
  InputDetected inputDetected = InputDetected.email;
  String? hintTxt;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final sufixIcon;
  final prefixText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final isReadOnly;

  CommomTextfiled({
    super.key,
    this.hintTxt,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.sufixIcon,
    this.prefixText,
    this.validator,
    this.onChange,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    Themes themes = Themes();
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChange,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        prefixText: prefixText,
        hintText: hintTxt,
        hintStyle: themes.fontSize16_400.copyWith(color: themes.grayColor),
        suffixIcon: sufixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}

enum InputDetected { mobile, email }
