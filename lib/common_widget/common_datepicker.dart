import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

void showPicker(BuildContext context, Function(DateTime) onSelectedItemChanged,
    List<String> items) {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          // Done button
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Done", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          // Cupertino Picker
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) => onSelectedItemChanged(value),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<DateTime?> holoDatePicker(BuildContext context,
    {DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? hintText}) async {
  return await DatePicker.showSimpleDatePicker(
    context,
    initialDate: initialDate ?? DateTime.now(), // Default to current date
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    dateFormat: "dd-MMMM-yyyy",
    titleText: hintText ?? 'Select Date',
    textColor: Theme.of(context).textTheme.titleMedium?.color,
    backgroundColor: Theme.of(context).colorScheme.surface,
    itemTextStyle: Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: themes.darkCyanBlue // Add Holo-style blue accent
            ),
  );
}
