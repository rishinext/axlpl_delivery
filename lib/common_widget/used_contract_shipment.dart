import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/home/controllers/home_controller.dart';
import 'package:axlpl_delivery/common_widget/common_appbar.dart';
import 'package:axlpl_delivery/common_widget/transation_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        appBar: commonAppbar('Contract Ledger'),
        body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 0.h,
          ),
          itemCount:
              homeController.usedContractModel.value?.transactions?.length ??
                  0, // Ensure this is not null before accessing length
          itemBuilder: (context, index) {
            final details =
                homeController.usedContractModel.value?.transactions?[index];
            DateTime txnDate;
            try {
              txnDate = DateFormat('dd-MM-yyyy').parse(details?.date ?? '');
            } catch (e) {
              txnDate = DateTime.now(); // fallback if invalid
            }

            final formattedDay = DateFormat('dd').format(txnDate); // "18"
            final formattedMonth = DateFormat('MMM').format(txnDate);
            final formattedYear = DateFormat('yyyy').format(txnDate);
            if (homeController.isUsedContractLoading.value == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (homeController.isUsedContractLoading.value ==
                    Status.error ||
                homeController.usedContractModel.value?.transactions == null ||
                homeController.usedContractModel.value!.transactions!.isEmpty) {
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
                    "Balance: \u20B9${details?.balance.toString()}" ?? 'N/A',
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
          padding: const EdgeInsets.all(16),
        ));
  }
}
