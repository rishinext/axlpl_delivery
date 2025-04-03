// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:axlpl_delivery/utils/utils.dart';
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

// Widget CommonDropdown(
//     {required String hint,
//     required Rxn<String> selectedValue,
//     required Function(String?) onChanged,
//     VoidCallback? onTap,
//     required List<String> items}) {
//   return

// }
class CommonDropdown<T> extends StatelessWidget {
  final String hint;
  final String? selectedValue; // ✅ Store ID, not name
  final Function(String?) onChanged;
  final VoidCallback? onTap;

  bool isLoading;
  final List<T> items;
  final String Function(T) itemLabel; // ✅ Extract Name
  final String Function(T) itemValue; // ✅ Extract ID

  CommonDropdown({
    Key? key,
    required this.hint,
    required this.selectedValue,
    required this.onChanged,
    required this.isLoading,
    required this.items,
    required this.itemLabel, // ✅ Function to get name
    required this.itemValue,
    this.onTap, // ✅ Function to get ID
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          onTap: onTap,
          isExpanded: true,
          hint: Text(hint),
          value: selectedValue, // ✅ Stores ID
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: itemValue(item), // ✅ Stores ID
              child: Text(itemLabel(item)), // ✅ Displays Name
            );
          }).toList(),
          onChanged: onChanged,
          icon: Icon(Icons.keyboard_arrow_down_outlined,
              size: 30, color: Colors.black),
        ),
      ),
    );
  }
}
