import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    final pickupDetailsController = Get.put(RunningDeliveryDetailsController());
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
                alignment:
                    Alignment.topRight, // Positions close button at top right
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20), // leaves space for close button
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        minHeight: 200, // Ensures some space even when loading
                        minWidth: 200,
                      ),
                      decoration: BoxDecoration(
                        color: themes.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        invoicePath + invoicePhoto,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
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
