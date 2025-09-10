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
  const PdfScreen({super.key});

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final details = homeController.contractDataModel.value?.contracts?[0];
    return CommonScaffold(
      appBar: commonAppbar('Contracts Details'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemCount:
                    homeController.contractDataModel.value?.contracts?.length ??
                        0,
                itemBuilder: (context, index) => Container(
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
                              child: infoCard('Start Date',
                                  details?.startDate.toString() ?? 'N/A')),
                          SizedBox(width: 12),
                          Expanded(
                              child: infoCard('End Date',
                                  '${details?.endDate.toString() ?? "N/A"}')),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                              child: infoCard('Category',
                                  '${details?.categoryName.toString() ?? "N/A"}')),
                          SizedBox(width: 12),
                          Expanded(
                              child: infoCard('Rate',
                                  details?.ratePerGram.toString() ?? 'N/A')),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                              child: infoCard('Weight',
                                  '${details?.weight.toString() ?? "N/A"}')),
                          SizedBox(width: 12),
                          Expanded(
                              child: infoCard('Billing Cycle',
                                  details?.ratePerGram.toString() ?? 'N/A')),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: infoCard(
                                  containerColor: Colors.green.shade100,
                                  'Status',
                                  textColor: details?.active == "Active"
                                      ? Colors.green.shade800
                                      : themes.redColor,
                                  '${details?.active.toString() ?? "N/A"}')),
                          SizedBox(width: 12),
                          SizedBox(
                              width: 150.w,
                              child: CommonButton(
                                title: 'View PDF',
                                backgroundColor: themes.darkCyanBlue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfViewerPage(
                                          pdfUrl: details?.viewLink ?? ''),
                                    ),
                                  );
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
