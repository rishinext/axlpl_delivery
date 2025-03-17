import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
    required Rxn<String> selectedValue,
    required Function(String?) onChanged,
    VoidCallback? onTap,
    required List<String> items}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    decoration: BoxDecoration(
      border: Border.all(color: themes.grayColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(hint),
        value: selectedValue.value,
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        onTap: onTap,
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 35,
          color: themes.grayColor,
        ),
      ),
    ),
  );
}
