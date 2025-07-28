import 'dart:io';
import 'package:axlpl_delivery/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextfiled extends StatelessWidget {
  final String? hintTxt;
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
  final maxNumberOfLines;
  final int? maxLength;

  const CommonTextfiled({
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
    this.maxNumberOfLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    Themes themes = Themes();

    if (Platform.isIOS) {
      // iOS Cupertino TextField
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lableText != null) ...[
            Text(
              lableText!,
              style: themes.fontSize16_400.copyWith(
                color: themes.darkCyanBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          CupertinoTextField(
            controller: controller,
            placeholder: hintTxt,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            enabled: isEnable,
            readOnly: isReadOnly,
            maxLength: maxLength,
            maxLines: obscureText
                ? 1
                : (maxLine ??
                    1), // Fix: Ensure maxLines is 1 when obscureText is true
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            onSubmitted: onSubmit,
            prefix: prefixIcon,
            suffix: sufixIcon,
            placeholderStyle: themes.fontSize16_400.copyWith(
              color: CupertinoColors.placeholderText,
            ),
            style: themes.fontSize16_400.copyWith(
              color: CupertinoColors.label,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: CupertinoColors.systemGrey4,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            inputFormatters: maxLength != null
                ? [LengthLimitingTextInputFormatter(maxLength)]
                : null,
          ),
          // Custom validation display for iOS
          if (validator != null)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller ?? TextEditingController(),
              builder: (context, value, child) {
                final error = validator!(value.text);
                if (error != null && value.text.isNotEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h, left: 4.w),
                    child: Text(
                      error,
                      style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                        fontSize: 12.sp,
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
        ],
      );
    } else {
      // Android Material TextField
      return TextFormField(
        enabled: isEnable,
        textInputAction: textInputAction,
        obscureText: obscureText,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        readOnly: isReadOnly,
        onFieldSubmitted: onSubmit,
        maxLength: maxLength,
        maxLines: obscureText
            ? 1
            : (maxLine ??
                1), // Fix: Ensure maxLines is 1 when obscureText is true
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
        inputFormatters: maxLength != null
            ? [LengthLimitingTextInputFormatter(maxLength)]
            : null,
      );
    }
  }
}

enum InputDetected { mobile, email }
