import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceImagePopup extends StatelessWidget {
  final String invoicePath;
  final String invoicePhoto;

  const InvoiceImagePopup({
    super.key,
    required this.invoicePath,
    required this.invoicePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: themes.whiteColor,
        backgroundColor: themes.darkCyanBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
      ),
      onPressed: () {
        // Show image in popup dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  // The image
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: themes.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InteractiveViewer(
                        child: Image.network(
                          invoicePath + invoicePhoto,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Cancel button (top-right)
                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Text('View Invoice'),
    );
  }
}
