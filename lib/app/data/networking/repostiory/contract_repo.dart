import 'dart:math';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/contract_view_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class ContractRepo {
  final ApiServices apiServices = ApiServices();
  Future<ContractViewModel?> contractViewRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final response = await apiServices.contractView(userID);

      return response.when(
        success: (body) {
          final data = ContractViewModel.fromJson(body);
          if (data.status == 'success') {
            return data;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${data.status}');
          }
          return null;
        },
        error: (error) {
          Utils().logError("Contract View Failed: ${error.toString()}");
          return null;
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
      return null;
    }
  }
}
