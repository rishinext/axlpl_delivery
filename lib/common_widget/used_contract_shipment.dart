import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/transation_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UsedContractShipment extends StatefulWidget {
  const UsedContractShipment({super.key});

  @override
  State<UsedContractShipment> createState() => _UsedContractShipmentState();
}

class _UsedContractShipmentState extends State<UsedContractShipment> {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
        appBar: commonAppbar('Used Contract'),
        body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 0.h,
          ),
          itemCount: homeController.invoiceListDataModel.value?.length ?? 0,
          itemBuilder: (context, index) {
            final details = homeController.invoiceListDataModel.value?[index];

            return TransactionTile(
              date: DateTime(2025, 1, 25),
              fromAccount: details?.custCompanyName.toString() ?? 'N/A',
              toAccount: details?.receiverCompanyName.toString() ?? 'N/A',
              currency: "\u20B9",
              shipmentID: details?.shipmentIds.toString() ?? 'N/A',
              amount: details?.totalAmt.toString() ?? '0',
              day: '25',
              month: 'Jan',
            );
          },
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
        ));
  }
}
