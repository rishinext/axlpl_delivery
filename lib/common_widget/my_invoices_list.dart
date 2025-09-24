import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_pdf_view.dart';
import 'package:axlpl_delivery/common_widget/common_textfiled.dart';
import 'package:axlpl_delivery/common_widget/container_textfiled.dart';
import 'package:axlpl_delivery/common_widget/pdf_view.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyInvoicesList extends StatefulWidget {
  const MyInvoicesList({super.key});

  @override
  State<MyInvoicesList> createState() => _MyInvoicesListState();
}

class _MyInvoicesListState extends State<MyInvoicesList> {
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppbar('Invoices'),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerTextfiled(
                hintText: 'Search Here',
                suffixIcon: Icon(
                  Icons.search,
                  color: themes.grayColor,
                ),
                controller: homeController.invoiceSearchController,
                onChanged: (value) {
                  homeController.filterInvoices(value ?? '');
                  return null;
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    homeController.showDatePickerDialog(context);
                  },
                  label: Text('Filter by Date'),
                  icon: Icon(
                    Icons.filter_list,
                    color: themes.whiteColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themes.darkCyanBlue,
                    foregroundColor: themes.whiteColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                if (homeController.isInvoiceLoading.value == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (homeController.isInvoiceLoading.value ==
                    Status.success) {
                  final filtered = homeController.filteredInvoiceList;
                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'No Invoices Available',
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: filtered.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10.h,
                      ),
                      itemBuilder: (context, index) {
                        final details = filtered[index];
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          tileColor: themes.whiteColor,
                          dense: false,
                          leading: CircleAvatar(
                            backgroundColor: themes.blueGray,
                            child: Image.asset(
                              invoiceLogo,
                            ),
                          ),
                          title: Text(
                            'Inv#: ${details?.invoiceNo.toString() ?? "N/A"}',
                            style: themes.fontSize14_500.copyWith(),
                          ),
                          subtitle: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(details?.invoiceDate != null
                                  ? DateFormat('dd MMM yyyy').format(
                                      DateTime.parse(
                                          details!.invoiceDate.toString()))
                                  : 'N/A'),
                              Text(
                                details?.paymentMode.toString() ?? 'N/A',
                                style: themes.fontSize14_400
                                    .copyWith(fontSize: 13.sp),
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                              onPressed: () => Get.to(() => CommonPdfView(
                                    link: details?.invoiceLink ?? '',
                                  )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themes.darkCyanBlue,
                                foregroundColor: themes.whiteColor,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              child: Text('View')),
                        );
                      },
                    );
                  }
                } else if (homeController.isInvoiceLoading.value ==
                    Status.error) {
                  return Center(
                    child: Text(
                      'Error loading invoices. Please try again.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ));
  }
}
