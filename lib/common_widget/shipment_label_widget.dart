import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShipmentLabelDialog extends StatelessWidget {
  final VoidCallback onPrint;
  TextEditingController labelCountController;

  ShipmentLabelDialog({
    Key? key,
    required this.onPrint,
    required this.labelCountController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('Shipment Label', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Label Count:', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 8.h),
          CommonTextfiled(
            controller: labelCountController,
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: onPrint,
                child: const Text('Print'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
