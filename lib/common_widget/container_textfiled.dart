import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerTextfiled extends StatelessWidget {
  String? hintText;
  final controller;
  final prefixIcon;
  final suffixIcon;
  final String? Function(String?)? onChanged;
  ContainerTextfiled({
    this.hintText,
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themes.lightGrayColor, // Light grey background
        borderRadius: BorderRadius.circular(30.r), // Rounded corners
      ),
      // padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorWidth: 2,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            hintText: "$hintText",
            hintStyle: themes.fontSize16_400,
            border: InputBorder.none, // Remove the default underline border
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
