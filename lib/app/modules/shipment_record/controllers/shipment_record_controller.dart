import 'package:axlpl_delivery/app/data/models/get_shipment_record_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_record_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/pod_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShipmentRecordController extends GetxController {
  final _repo = PodRepo();

  final isShipmentRecord = Status.initial.obs;

  final Rxn<ShipmentRecordData> shipmentRecord = Rxn<ShipmentRecordData>();
  final shipmentController = TextEditingController();

  Future<void> getShipmentRecord(final shipmentID) async {
    try {
      isShipmentRecord.value = Status.loading;
      final result = await _repo.shipmentRecordRepo(shipmentID);

      if (result.sId != null && result.sId!.isNotEmpty) {
        shipmentRecord.value = result;
        isShipmentRecord.value = Status.success;
      } else {
        shipmentRecord.value = null;
        isShipmentRecord.value = Status.error;
        Utils().logInfo('No Shipment Record Found!');
      }
    } catch (e) {
      Utils().logError(e.toString());
      shipmentRecord.value = null;
      isShipmentRecord.value = Status.error;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}
