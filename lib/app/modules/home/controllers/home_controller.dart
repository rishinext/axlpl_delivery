import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/get_ratting_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/home_repo.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeRepo = HomeRepository();

  TextEditingController searchController = TextEditingController();
  Rxn<DashboardDataModel> dashboardDataModel = Rxn<DashboardDataModel>();
  Rxn<RattingDataModel> rattingDataModel = Rxn<RattingDataModel>();
  RxBool isLoading = false.obs;
  var isRattingData = Status.initial.obs;

  var scannedCode = ''.obs;
  final profileController = Get.put(ProfileController());
  Future<void> getDashborad() async {
    isLoading.value = true;
    try {
      Utils().logInfo("Fetching dashboard data...");
      final data = await homeRepo.dashboardDataRepo();

      if (data != null) {
        Utils().logInfo("Dashboard data received: ${data.toString()}");
        dashboardDataModel.value = data;
      } else {
        Utils().logError(
            "Dashboard data is null - check repository logs for details");
      }
    } catch (error) {
      Utils().logError(
        'Error getting dashboard: $error',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRattingData() async {
    isRattingData.value = Status.loading;

    try {
      final data = await homeRepo.getRattingRepo();
      if (data != null) {
        rattingDataModel.value = data;
        isRattingData.value = Status.success;
        Utils().logInfo("Ratting data retrieved successfully");
      } else {
        isRattingData.value = Status.error;
        Utils().logError("Ratting data is null");
      }
    } catch (error) {
      isRattingData.value = Status.error;
      Utils().logError("Error getting ratting: $error");
    }
  }

  void updateCode(String code) {
    scannedCode.value = code;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getDashborad();
    getRattingData();
    super.onInit();
  }
}
