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
  var isTrasferLoading = Status.initial.obs;
  RxInt isSelected = 0.obs;

  var selectedMessenger = ''.obs;
  void selectedContainer(int index) {
    isSelected.value = index;
  }

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

  Future<void> transferShipment(
    final shipmentID,
    final transferToID,
  ) async {
    isMessangerLoading.value = Status.loading;
    try {
      final success = await shipmentRepo.trasferShipmentRepo(
        shipmentID,
        transferToID,
        'pickup',
      );
      if (success) {
        Get.snackbar('success', 'Shipment Transfer Success!');
        isMessangerLoading.value = Status.success;
      } else {
        Get.snackbar('failed', 'Shipment Transfer Failed!');
        isMessangerLoading.value = Status.error;
      }
    } catch (e) {
      Get.snackbar('failed', 'Shipment Transfer Failed!');
      isMessangerLoading.value = Status.error;
    }
  }

  void filterByQuery(String query) {
    if (query.isEmpty) {
      filteredPickupList.value = pickupList;
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredPickupList.value = pickupList.where((pickup) {
        final pincode = (pickup.pincode ?? '').toLowerCase();
        final name = (pickup.name ?? '').toLowerCase();
        final address = (pickup.address1 ?? '').toLowerCase();
        final city = (pickup.cityName ?? '').toLowerCase();
        final shipmentID = (pickup.shipmentId ?? '').toLowerCase();

        return pincode.contains(lowerQuery) ||
            name.contains(lowerQuery) ||
            address.contains(lowerQuery) ||
            city.contains(lowerQuery) ||
            shipmentID.contains(lowerQuery);
      }).toList();
    }
  }

  Future<void> openMapWithAddress(
      String companyName, String address, String pincode) async {
    final fullQuery = '$companyName, $address, $pincode';
    final encodedQuery = Uri.encodeComponent(fullQuery);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$encodedQuery';
    final Uri url = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getPickupData();
    getMessangerData();
    super.onInit();
  }
}
