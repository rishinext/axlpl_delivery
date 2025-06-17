import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CommonTextfiled extends StatelessWidget {
  final textFieldFocusNode = FocusNode();
  String? hintTxt;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final sufixIcon;
  final prefixIcon;
  final prefixText;
  final lableText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final void Function(String?)? onSubmit;
  final isReadOnly;
  final isEnable;
  final maxLine;

  CommonTextfiled({
    super.key,
    this.hintTxt,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.sufixIcon,
    this.prefixIcon,
    this.prefixText,
    this.validator,
    this.onChanged,
    this.isReadOnly = false,
    this.textInputAction,
    this.isEnable = true,
    this.onSubmit,
    this.lableText,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    Themes themes = Themes();
    return TextFormField(
      // maxLines: maxLine,
      enabled: isEnable,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      readOnly: isReadOnly,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: lableText,
        prefixText: prefixText,
        hintText: hintTxt,
        hintStyle: themes.fontSize16_400.copyWith(color: themes.grayColor),
        suffixIcon: sufixIcon,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0.r),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}

enum InputDetected { mobile, email }
