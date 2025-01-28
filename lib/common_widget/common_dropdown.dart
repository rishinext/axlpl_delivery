import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dropdownText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: themes.fontSize16_400.copyWith(fontSize: 14.sp),
    ),
  );
}

Widget commomDropdown(
    {required String hint,
    required selectedValue,
    required Function(String?) onChanged,
    required items}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      border: Border.all(color: themes.grayColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(hint),
        value: selectedValue.value,
        items: items,
        onChanged: onChanged,
        icon: Icon(Icons.keyboard_arrow_down),
      ),
    ),
  );
}
