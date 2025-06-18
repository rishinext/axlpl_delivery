import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget infoCard(String label, String value) {
  return Column(
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey[700])),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              value,
              style: themes.fontSize14_500.copyWith(fontSize: 12.sp),
            ),
          )),
    ],
  );
}

// Helper widget for two-column rows in insurance details
Widget infoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    ],
  );
}
