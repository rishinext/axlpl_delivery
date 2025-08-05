import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickdup_delivery_details/controllers/running_delivery_details_controller.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_scaffold.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final historyController = Get.put(HistoryController());
    final runningController = Get.put(RunningDeliveryDetailsController());
    return CommonScaffold(
      appBar: commonAppbar('Cash Collection'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            // spacing: 20,
            children: [
              Obx(() {
                // Calculate total cash amount from ALL cashCollList (not filtered)
                double totalCashAmount = 0.0;
                for (var cash in historyController.cashCollList) {
                  if (cash.cashamount != null) {
                    try {
                      totalCashAmount +=
                          double.parse(cash.cashamount.toString());
                    } catch (e) {
                      // Handle parsing error if any
                    }
                  }
                }

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themes.darkCyanBlue,
                        themes.darkCyanBlue.withOpacity(0.8)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: themes.darkCyanBlue.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 20.h, bottom: 15.h),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: themes.whiteColor,
                          size: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Cash Collection',
                                  style: themes.fontReboto16_600.copyWith(
                                    color: themes.whiteColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Center(
                                child: Text(
                                  '\u{20B9}${totalCashAmount.toStringAsFixed(2)}',
                                  style: themes.fontReboto16_600.copyWith(
                                    color: themes.whiteColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: CommonTextfiled(
                              isReadOnly: true,
                              controller: historyController.fromDateController,
                              hintTxt: 'From',
                              lableText: 'From',
                              prefixIcon: InkWell(
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: themes.darkCyanBlue,
                                              onPrimary: themes.whiteColor,
                                              onSurface: themes.blackColor,
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    themes.darkCyanBlue,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                    if (selectedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(selectedDate);
                                      historyController.fromDateController
                                          .text = formattedDate;
                                      historyController
                                          .filterCashCollectionByDateRange();
                                    }
                                  },
                                  child: Icon(Icons.calendar_today)),
                              sufixIcon: IconButton(
                                onPressed: () {
                                  historyController.fromDateController.clear();
                                  historyController
                                      .filterCashCollectionByDateRange();
                                },
                                icon: Icon(Icons.clear, size: 20.w),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: CommonTextfiled(
                            isReadOnly: true,
                            controller: historyController.toDateController,
                            hintTxt: 'To',
                            lableText: 'To',
                            prefixIcon: InkWell(
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: themes.darkCyanBlue,
                                            onPrimary: themes.whiteColor,
                                            onSurface: themes.blackColor,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  themes.darkCyanBlue,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  if (selectedDate != null) {
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(selectedDate);
                                    historyController.toDateController.text =
                                        formattedDate;
                                    historyController
                                        .filterCashCollectionByDateRange();
                                  }
                                },
                                child: Icon(Icons.calendar_today)),
                            sufixIcon: IconButton(
                              onPressed: () {
                                historyController.toDateController.clear();
                                historyController
                                    .filterCashCollectionByDateRange();
                              },
                              icon: Icon(Icons.clear, size: 20.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              historyController.clearDateRangeFilter();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themes.grayColor,
                              foregroundColor: themes.whiteColor,
                            ),
                            child: Text('Clear Filter'),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              historyController
                                  .filterCashCollectionByDateRange();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themes.darkCyanBlue,
                              foregroundColor: themes.whiteColor,
                            ),
                            child: Text('Apply Filter'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (historyController.isCashCollLoading.value ==
                    Status.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                // Debug info
                if (historyController.cashCollList.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                        'No Cash Collection Data Found!',
                        style: themes.fontReboto16_600,
                      ),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          historyController.getCashCollectionHistory();
                        },
                        child: Text('Retry Loading Data'),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Status: ${historyController.isCashCollLoading.value.name}',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ));
                }

                if (historyController.filteredCashCollList.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                        'No Data Found for Selected Date!',
                        style: themes.fontReboto16_600,
                      ),
                      // SizedBox(height: 10.h),
                      // Text(
                      //   'Total records: ${historyController.cashCollList.length}',
                      //   style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     historyController.clearDateFilter();
                      //   },
                      //   child: Text('Clear Filter'),
                      // ),
                    ],
                  ));
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 1.h,
                    ),
                    itemCount: historyController.filteredCashCollList.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cash =
                          historyController.filteredCashCollList[index];

                      // Format date in Indian style (DD/MM/YYYY)
                      String formattedDate = "N/A";
                      if (cash.createdDate != null) {
                        try {
                          DateTime parsedDate =
                              DateTime.parse(cash.createdDate.toString());
                          formattedDate =
                              DateFormat('dd MMMM yy').format(parsedDate);
                        } catch (e) {
                          formattedDate = cash.createdDate.toString();
                        }
                      }

                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: ListTile(
                          onTap: () {
                            runningController
                                .fetchTrackingData(cash.shipmentId.toString());
                            Get.toNamed(
                              Routes.RUNNING_DELIVERY_DETAILS,
                              arguments: {
                                'shipmentID': cash.shipmentId.toString(),
                                // 'status': data.status.toString(),
                                // 'invoicePath': data.invoicePath,
                                // 'invoicePhoto': data.invoiceFile,
                                // 'paymentMode': data.paymentMode,
                                // 'date': data.date,
                                // 'cashAmt': data.totalCharges
                              },
                            );
                          },
                          tileColor: themes.whiteColor,
                          dense: false,
                          // leading: CircleAvatar(
                          //   backgroundColor: themes.blueGray,
                          //   child: Image.asset(
                          //     'assets/clockicon.png',
                          //     width: 18.w,
                          //   ),
                          // ),
                          title: Text("${formattedDate}"),
                          //  Text(
                          //   "ShipmentId : ${cash.shipmentId}",
                          //   style: themes.fontSize14_400,
                          // ),
                          subtitle: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${cash.shipmentId.toString()}/ ${cash.paymentMode} /${cash.subPaymentMode}"),
                              Text(cash.customerName.toString(),
                                  style: themes.fontSize14_400
                                      .copyWith(fontSize: 8.sp)),
                            ],
                          ),
                          trailing: RichText(
                              text: TextSpan(
                            text: ' \u{20B9}',
                            style: TextStyle(
                              color: themes.darkCyanBlue,
                              fontSize: 16.sp,
                            ),
                            children: [
                              TextSpan(
                                text: cash.cashamount?.toString() ?? '0.00',
                                style: themes.fontReboto16_600.copyWith(
                                  color: themes.darkCyanBlue,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                  text: ' cr',
                                  style: themes.fontSize14_400.copyWith(
                                      fontSize: 13.sp, color: Colors.green))
                            ],
                          )),
                          // trailing: CircleAvatar(
                          //   backgroundColor: themes.lightCream,
                          //   // radius: 15,
                          //   child: Icon(
                          //     Icons.arrow_forward,
                          //     size: 20.w,
                          //   ),
                          // ),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
