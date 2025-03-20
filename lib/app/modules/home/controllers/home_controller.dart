import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/home_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeRepo = HomeRepository();

  TextEditingController searchController = TextEditingController();
  Rxn<DashboardDataModel> dashboardDataModel = Rxn<DashboardDataModel>();
  RxBool isLoading = false.obs;

  Future<void> getDashborad() async {
    isLoading.value = true;
    try {
      final data = await homeRepo.dashboardDataRepo();
      if (data != null) {
        dashboardDataModel.value = data;
        Utils().logInfo("Dashboard data retrieved successfully");
      } else {
        Utils().logError("Dashboard data is null", '');
      }
    } catch (error, stackTrace) {
      Utils().logError('Error getting dashboard', error.toString());
      Utils().logError(
          'Stack Trace', stackTrace.toString()); // Log the stack trace
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDashborad();
  }
}
