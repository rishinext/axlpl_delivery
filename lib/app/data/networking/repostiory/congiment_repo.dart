import 'dart:convert';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/congiment_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CongimentRepo {
  final ApiServices _apiServices = ApiServices();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<List<ShipmentDataList>?> getConsigmentRepo(final congimentID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      // final userID = userData?.messangerdetail?.id?.toString() ??
      //     userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getConsignment(
        congimentID.toString(),
        branchID,
        token.toString(),
      );
      return response.when(success: (body) async {
        final parsed = CongismentModel.fromJson(body);
        final jsonString = json.encode(parsed.toJson());
        await storage.write(
          key: LocalStorage().shipmentData,
          value: jsonString,
        );
        return parsed.shipment?.first.shipmentData ?? [];
      }, error: (e) {
        throw Exception("Error fetching shipment data: $e");
      });
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return [];
  }
}
