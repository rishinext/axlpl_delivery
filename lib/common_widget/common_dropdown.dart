// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
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
  final String? selectedValue;
  final Function(String?) onChanged;
  final VoidCallback? onTap;
  final bool isLoading;
  final List<T> items;
  final String Function(T) itemLabel;
  final String Function(T) itemValue;
  final isSearchable;
  CommonDropdown({
    Key? key,
    required this.hint,
    required this.selectedValue,
    required this.onChanged,
    required this.isLoading,
    required this.items,
    required this.itemLabel,
    required this.itemValue,
    this.onTap,
    this.isSearchable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      items: items.map(itemLabel).toList(),
      selectedItem: selectedValue != null
          ? () {
              try {
                return itemLabel(items.firstWhere(
                  (e) => itemValue(e) == selectedValue,
                ));
              } catch (_) {
                return itemLabel(items.first);
              }
            }()
          : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        showSearchBox: isSearchable ?? false,
        searchFieldProps: TextFieldProps(
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      onChanged: (label) {
        final matchedItem = items.firstWhere(
          (item) => itemLabel(item) == label,
          orElse: () => items.first, // return first item to match T type
        );
        onChanged(itemValue(matchedItem));
      },
    );
  }
}
