import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/used_contract_shipment.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContractListWidget extends StatelessWidget {
  const ContractListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    String formatDate(String? raw) {
      if (raw == null || raw.trim().isEmpty) return 'N/A';
      try {
        final dt = DateTime.parse(raw);
        return DateFormat('dd MMM yy').format(dt);
      } catch (_) {
        return raw;
      }
    }

    return Scaffold(
      appBar: commonAppbar('Contracts'),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.separated(
              itemCount:
                  homeController.contractDataModel.value?.contracts?.length ??
                      0,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                final details =
                    homeController.contractDataModel.value?.contracts?[index];
                String formatDate(String? rawDate) {
                  if (rawDate == null) return 'N/A';
                  try {
                    final parsedDate = DateTime.parse(rawDate);
                    return DateFormat('dd MMM yyyy').format(parsedDate);
                  } catch (e) {
                    return rawDate; // Fallback to raw string if parsing fails
                  }
                }

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  color: themes.whiteColor,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.r),
                    onTap: () async {
                      await homeController.usedContract(homeController
                          .customerDashboardDataModel.value?.contractID);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsedContractShipment(
                            totalValue: details?.assignedValue?.toString(),
                            usedValue: details?.usedValue?.toString(),
                            details: details,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: themes.blueGray,
                                child: Image.asset(contractLogo, width: 18.w),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    details?.categoryName?.toString() ?? 'N/A',
                                    style: themes.fontSize14_500.copyWith(),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    details?.assignedValue != null
                                        ? '₹${details!.assignedValue}'
                                        : 'N/A',
                                  ),
                                  SizedBox(height: 12.h),
                                  // Adaptive date display: row when fits, otherwise split into two lines
                                ],
                              ),
                              SizedBox(width: 12.w),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: details?.active == 'Active'
                                      ? Colors.green.shade100
                                      : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8.w),
                                  child: Text(
                                    details?.active?.toString() ?? 'N/A',
                                    style: TextStyle(
                                      color: details?.active == 'Active'
                                          ? Colors.green.shade800
                                          : themes.redColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  formatDate(details?.startDate),
                                  style: themes.fontSize14_400
                                      .copyWith(fontSize: 13.sp),
                                ),
                                Text('  to  ',
                                    style: themes.fontSize14_400
                                        .copyWith(fontSize: 13.sp)),
                                Text(
                                  formatDate(details?.endDate),
                                  overflow: TextOverflow.ellipsis,
                                  style: themes.fontSize14_400
                                      .copyWith(fontSize: 13.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
