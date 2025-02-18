import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/home_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeRepo = HomeRepository();

  TextEditingController searchController = TextEditingController();
  DashboardDataModel dashboardDataModel = DashboardDataModel();
  RxBool isLoading = false.obs;

  Future<void> getDashborad() async {
    isLoading.value = true;
    try {
      final data = await homeRepo.dashboardDataRepo();
      if (data != null) {
        dashboardDataModel = data;
        Utils().logInfo("Dashboard data retrive successfully");
      } else {
        Utils().logError("Dashboard data is null", '');
      }
    } catch (error) {
      Utils().logError('Error getting dashborad', error);
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
