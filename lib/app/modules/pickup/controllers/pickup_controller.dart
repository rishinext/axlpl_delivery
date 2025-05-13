import 'package:axlpl_delivery/app/data/models/messnager_model.dart';
import 'package:axlpl_delivery/app/data/models/pickup_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pickup_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/shipnow_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupController extends GetxController {
  //TODO: Implement PickupController

  final pickupRepo = PickupRepo();
  final shipmentRepo = ShipnowRepo();

  final pickupList = <RunningPickUp>[].obs;
  final messangerList = <MessangerList>[].obs;
  final RxList<RunningPickUp> filteredPickupList = <RunningPickUp>[].obs;

  var isPickupLoading = Status.initial.obs;
  var isMessangerLoading = Status.initial.obs;

  final TextEditingController pincodeController = TextEditingController();

  Future<void> getMessangerData() async {
    isMessangerLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getMessangerRepo('0');
      if (success != null) {
        messangerList.value = success;

        isMessangerLoading.value = Status.success;
      } else {
        Utils().logInfo('No messanger Data Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      messangerList.value = [];
    }
  }

  Future<void> getPickupData() async {
    isPickupLoading.value = Status.loading;
    try {
      final success = await pickupRepo.getAllPickupRepo('0');
      if (success != null) {
        pickupList.value = success;
        filteredPickupList.value = success;
        isPickupLoading.value = Status.success;
      } else {
        Utils().logInfo('No pickup Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      pickupList.value = [];
      filteredPickupList.value = [];
    }
  }

  void filterByPincode(String query) {
    if (query.isEmpty) {
      filteredPickupList.value = pickupList;
    } else {
      filteredPickupList.value = pickupList
          .where((pickup) => (pickup.pincode ?? '').contains(query.trim()))
          .toList();
    }
  }

  Future<void> openMapWithAddress(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress';
    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(
        url,
        mode: LaunchMode
            .externalNonBrowserApplication, // ✅ open inside WebView as last option
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPickupData();
  }
}
