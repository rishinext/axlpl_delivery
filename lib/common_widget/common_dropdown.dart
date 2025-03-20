// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:axlpl_delivery/utils/utils.dart';

Widget dropdownText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: themes.fontSize16_400.copyWith(fontSize: 14.sp),
    ),
  );
}

// Widget CommonDropdown(
//     {required String hint,
//     required Rxn<String> selectedValue,
//     required Function(String?) onChanged,
//     VoidCallback? onTap,
//     required List<String> items}) {
//   return

// }
class CommonDropdown extends StatelessWidget {
  final String hint;
  final String? selectedValue; // ✅ Use nullable String instead of Rxn<String>
  final Function(String?) onChanged;
  final VoidCallback? onTap;
  final List<String> items;

  const CommonDropdown({
    Key? key,
    required this.hint,
    required this.selectedValue, // ✅ Now just a normal value
    required this.onChanged,
    this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          value: selectedValue, // ✅ Now just a normal value
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
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
}
