import 'package:axlpl_delivery/app/data/models/contract_details_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_dashboard_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/pdf_view.dart';
import 'package:axlpl_delivery/common_widget/tracking_info_widget.dart';
import 'package:axlpl_delivery/common_widget/transation_tile_widget.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../app/data/models/contract_view_model.dart';

class UsedContractShipment extends StatefulWidget {
  final totalValue;
  final usedValue;
  UsedContractShipment({super.key, this.usedValue, this.totalValue});

  @override
  State<UsedContractShipment> createState() => _UsedContractShipmentState();
}

class _UsedContractShipmentState extends State<UsedContractShipment> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
        appBar: commonAppbar('Contract Ledger'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount:
                    homeController.contractDataModel.value?.contracts?.length ??
                        0,
                itemBuilder: (context, index) {
                  final details =
                      homeController.contractDataModel.value?.contracts?[index];
                  return Container(
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
                                    'Used Amount',
                                    "\u{20B9}${details?.usedValue.toString()}" ??
                                        'N/A')),
                            SizedBox(width: 12),
                            Expanded(
                                child: infoCard(
                                    'Total Amount',
                                    "\u{20B9}${details?.assignedValue.toString()}" ??
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
                                    containerColor: details?.active == "Active"
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                    'Status',
                                    textColor: details?.active == "Active"
                                        ? Colors.green.shade800
                                        : themes.redColor,
                                    '${details?.active.toString() ?? "N/A"}')),
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
                                          pdfUrl: details?.viewLink ?? ''),
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
                  );
                },
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 16),
              //   child: Text(
              //       'Used Contract \u{20B9}${widget.usedValue} of \u{20B9}${widget.totalValue.toString()} ',
              //       style: TextStyle(
              //           fontWeight: FontWeight.w600, color: themes.blackColor)),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: RichText(
                  text: TextSpan(
                    style: themes.fontSize14_500.copyWith(
                      color: themes.blackColor,
                    ),
                    children: [
                      const TextSpan(text: 'Used Contract '),
                      TextSpan(
                        text: '₹${widget.usedValue}',
                        style: themes.fontSize14_500.copyWith(
                          color: themes.redColor,
                        ),
                      ),
                      const TextSpan(text: ' of '),
                      TextSpan(
                        text: '₹${widget.totalValue}',
                        style: themes.fontSize14_500.copyWith(
                          color: themes.darkCyanBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ListView.separated(
                physics: ScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 0.h,
                ),
                itemCount: homeController
                        .usedContractModel.value?.transactions?.length ??
                    0, // Ensure this is not null before accessing length
                itemBuilder: (context, index) {
                  final details = homeController
                      .usedContractModel.value?.transactions?[index];
                  DateTime txnDate;
                  try {
                    txnDate =
                        DateFormat('dd-MM-yyyy').parse(details?.date ?? '');
                  } catch (e) {
                    txnDate = DateTime.now(); // fallback if invalid
                  }

                  final formattedDay = DateFormat('dd').format(txnDate); // "18"
                  final formattedMonth = DateFormat('MMM').format(txnDate);
                  final formattedYear = DateFormat('yyyy').format(txnDate);
                  if (homeController.isUsedContractLoading.value ==
                      Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (homeController.isUsedContractLoading.value ==
                          Status.error ||
                      homeController.usedContractModel.value?.transactions ==
                          null ||
                      homeController
                          .usedContractModel.value!.transactions!.isEmpty) {
                    return Center(
                      child: Text(
                        'No Transactions Found',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    );
                  } else if (homeController.isUsedContractLoading.value ==
                      Status.success) {
                    return TransactionTile(
                      date: DateTime(2025, 1, 25),
                      fromAccount:
                          "Total: \u20B9${homeController.usedContractModel.value?.assignedValue}",
                      toAccount:
                          "Balance: \u20B9${details?.balance.toString()}" ??
                              'N/A',
                      currency: "\u20B9",
                      amount: details?.debit.toString() ?? '0',
                      day: formattedDay ?? '',
                      month: formattedMonth ?? '',
                      year: formattedYear ?? '',
                      shipmentID: details?.shipmentID ?? 'N/A',
                    );
                  }
                  return const SizedBox.shrink();
                },
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ],
          ),
        ));
  }
}
