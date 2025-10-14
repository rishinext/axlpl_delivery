import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/contract_details_screen.dart';
import 'package:axlpl_delivery/common_widget/contract_home_screen_widget.dart';
import 'package:axlpl_delivery/common_widget/tracking_info_widget.dart';
import 'package:axlpl_delivery/common_widget/used_contract_shipment.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContractListWidget extends StatelessWidget {
  const ContractListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

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
                physics: ScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                itemBuilder: (context, index) {
                  final details =
                      homeController.contractDataModel.value?.contracts?[index];
                  return ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                      onTap: () async {
                        homeController
                            .usedContract(homeController
                                .customerDashboardDataModel.value?.contractID)
                            .then(
                              (value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsedContractShipment(
                                      totalValue:
                                          details?.assignedValue.toString(),
                                      usedValue: details?.usedValue.toString(),
                                      details: details,
                                    ),
                                  )),
                            );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => PdfScreen(
                        //         Contract: details,
                        //       ),
                        //     ));
                      },
                      tileColor: themes.whiteColor,
                      dense: false,
                      leading: CircleAvatar(
                        backgroundColor: themes.blueGray,
                        child: Image.asset(
                          contractLogo,
                          width: 18.w,
                        ),
                      ),
                      title: Text(
                        '${details?.categoryName.toString() ?? "N/A"}',
                        style: themes.fontSize14_500.copyWith(),
                      ),
                      subtitle: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(details?.assignedValue.toString() ?? 'N/A'),
                          Text(
                            details?.startDate.toString() ?? 'N/A',
                            style:
                                themes.fontSize14_400.copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                            color: details?.active == "Active"
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8.w),
                          child: Text(
                              style: TextStyle(
                                  color: details?.active == "Active"
                                      ? Colors.green.shade800
                                      : themes.redColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                              '${details?.active.toString() ?? "N/A"}'),
                        ),
                      )
                      // infoCard(
                      //     containerColor: details?.active == "Active"
                      //         ? Colors.green.shade100
                      //         : Colors.red.shade100,
                      //     'Status',
                      //     textColor: details?.active == "Active"
                      //         ? Colors.green.shade800
                      //         : themes.redColor,
                      //     '${details?.active.toString() ?? "N/A"}'),
                      // trailing: CircleAvatar(
                      //   backgroundColor: themes.blueGray,
                      //   child: Icon(Icons.arrow_forward),
                      // ),
                      );
                },
              ),
            ],
          ),
        ));
  }
}
