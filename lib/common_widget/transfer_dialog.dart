import 'package:axlpl_delivery/app/data/models/messnager_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/modules/pickup/controllers/pickup_controller.dart';
import 'package:axlpl_delivery/common_widget/common_dropdown.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showTransferDialog(VoidCallback ontap) {
  final formKey = GlobalKey<FormState>();
  final pickupController = Get.find<PickupController>();
  Get.defaultDialog(
      title: "Messangers",
      content: Form(
        key: formKey,
        child: SizedBox(
          width: 400.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                dropdownText('Messanger List'),
                Obx(
                  () => CommonDropdown<MessangerList>(
                    isSearchable: true,
                    hint: 'Select Messanger',
                    selectedValue: pickupController.selectedMessenger.value,
                    isLoading: pickupController.isMessangerLoading.value ==
                        Status.loading,
                    items: pickupController.messangerList,
                    itemLabel: (c) => c.name ?? 'Unknown',
                    itemValue: (c) => c.id.toString(),
                    onChanged: (val) {
                      pickupController.selectedMessenger.value = val!;
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      radius: 10,
      textConfirm: "Transfer",
      textCancel: "Cancel",
      confirmTextColor: themes.whiteColor,
      onConfirm: ontap);
}
