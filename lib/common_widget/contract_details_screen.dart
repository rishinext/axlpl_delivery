import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/contract_view_model.dart';
import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/pdf_view.dart';
import 'package:axlpl_delivery/common_widget/tracking_info_widget.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PdfScreen extends StatefulWidget {
  final Contract;
  PdfScreen({super.key, this.Contract});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final details = homeController.contractDataModel.value?.contracts?[0];
    log(widget.Contract.id.toString());
    return CommonScaffold(
      appBar: commonAppbar('Contracts Details'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 320.h,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themes.whiteColor,
                  borderRadius: BorderRadius.circular(12).r,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: infoCard(
                                'Start Date',
                                widget.Contract?.startDate.toString() ??
                                    'N/A')),
                        SizedBox(width: 12),
                        Expanded(
                            child: infoCard('End Date',
                                '${widget.Contract?.endDate.toString() ?? "N/A"}')),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: infoCard('Category',
                                '${widget.Contract?.categoryName.toString() ?? "N/A"}')),
                        SizedBox(width: 12),
                        Expanded(
                            child: infoCard(
                                'Rate',
                                widget.Contract?.ratePerGram.toString() ??
                                    'N/A')),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: infoCard('Weight',
                                '${widget.Contract?.weight.toString() ?? "N/A"}')),
                        SizedBox(width: 12),
                        Expanded(
                            child: infoCard(
                                'Billing Cycle',
                                widget.Contract?.ratePerGram.toString() ??
                                    'N/A')),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: infoCard(
                                'Used Amount',
                                "\u{20B9}${widget.Contract?.usedValue.toString()}" ??
                                    'N/A')),
                        SizedBox(width: 12),
                        Expanded(
                            child: infoCard(
                                'Total Amount',
                                "\u{20B9}${widget.Contract?.assignedValue.toString()}" ??
                                    'N/A')),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                            child: infoCard(
                                containerColor:
                                    widget.Contract?.active == "Active"
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                'Status',
                                textColor: widget.Contract?.active == "Active"
                                    ? Colors.green.shade800
                                    : themes.redColor,
                                '${widget.Contract?.active.toString() ?? "N/A"}')),
                        SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: themes.darkCyanBlue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViewerPage(
                                      pdfUrl: widget.Contract?.viewLink ?? ''),
                                ),
                              );
                            },
                            child: Text('View PDF'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
