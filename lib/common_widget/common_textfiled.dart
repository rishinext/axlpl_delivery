import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CommomTextfiled extends StatelessWidget {
  final textFieldFocusNode = FocusNode();
  String? hintTxt;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final sufixIcon;
  final prefixText;
  final lableText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;

  final void Function(String?)? onSubmit;

  final isReadOnly;
  final isEnable;

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
    this.textInputAction,
    this.isEnable = true,
    this.onSubmit,
    this.lableText,
  });

  @override
  Widget build(BuildContext context) {
    Themes themes = Themes();
    return TextFormField(
      enabled: isEnable,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChange,
      readOnly: isReadOnly,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        labelText: lableText,
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
