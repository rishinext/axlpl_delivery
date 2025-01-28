import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
