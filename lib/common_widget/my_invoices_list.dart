import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/common_button.dart';
import 'package:axlpl_delivery/common_widget/common_pdf_view.dart';
import 'package:axlpl_delivery/common_widget/pdf_view.dart';
import 'package:axlpl_delivery/utils/assets.dart';
import 'package:axlpl_delivery/utils/utils.dart';
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
        body: Obx(() {
          if (homeController.isInvoiceLoading.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (homeController.isInvoiceLoading.value == Status.success) {
            final invoices = homeController.invoiceListDataModel.value;
            if (invoices == null || invoices.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Invoices Available',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                  itemCount:
                      homeController.invoiceListDataModel.value?.length ?? 0,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    final details =
                        homeController.invoiceListDataModel.value?[index];
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
                        'Invoice No: ${details?.invoiceNo.toString() ?? "N/A"}',
                        style: themes.fontSize14_500.copyWith(),
                      ),
                      subtitle: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(details?.invoiceDate.toString() ?? 'N/A'),
                          Text(
                            details?.paymentMode.toString() ?? 'N/A',
                            style:
                                themes.fontSize14_400.copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                          onPressed: () => Get.to(() => CommonPdfView(
                                link: 'https://new.axlpl.com/admin/customer/invoice_view/656920' ??
                                    'https://new.axlpl.com/admin/customer/view_contract/3305/26',
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themes.darkCyanBlue,
                            foregroundColor: themes.whiteColor,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: Text('View')),
                    );
                  },
                ),
              );
            }
          } else if (homeController.isInvoiceLoading.value == Status.error) {
            return Center(
              child: Text(
                'Error loading invoices. Please try again.',
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
