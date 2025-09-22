import 'package:axlpl_delivery/app/data/models/contract_view_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_invoice_model.dart';
import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/get_ratting_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/home_repo.dart';
import 'package:axlpl_delivery/app/modules/profile/controllers/profile_controller.dart';
import 'package:axlpl_delivery/app/modules/shipnow/controllers/shipnow_controller.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final homeRepo = HomeRepository();

  TextEditingController searchController = TextEditingController();
  Rxn<DashboardDataModel> dashboardDataModel = Rxn<DashboardDataModel>();
  Rxn<CustomerDashboardDataModel> customerDashboardDataModel =
      Rxn<CustomerDashboardDataModel>();

  Rxn<RattingDataModel> rattingDataModel = Rxn<RattingDataModel>();

  Rxn<ContractViewModel> contractDataModel = Rxn<ContractViewModel>();

  var invoiceListDataModel = Rxn<List<CustomerInvoiceModel?>>();

  RxBool isLoading = false.obs;
  var isCustomerDashboard = Status.initial.obs;
  var isContractLoading = Status.initial.obs;
  var isInvoiceLoading = Status.initial.obs;
  var isRattingData = Status.initial.obs;

  var scannedCode = ''.obs;
  final profileController = Get.put(ProfileController());
  final shipController = Get.put(ShipnowController());

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

// Your existing function is fine.
  Future<void> getCustomerDashborad() async {
    isCustomerDashboard.value = Status.loading;
    try {
      Utils().logInfo("Fetching customer dashboard data...");
      final data = await homeRepo.customerDashboardDataRepo();

      if (data != null) {
        Utils().logInfo("Customer Dashboard data received: ${data.toString()}");
        customerDashboardDataModel.value = data;
        isCustomerDashboard.value = Status.success;
      } else {
        Utils().logError(
            "Dashboard data is null - check repository logs for details");
        isCustomerDashboard.value = Status.error;
      }
    } catch (error) {
      Utils().logError('Error getting dashboard: $error');
      isCustomerDashboard.value = Status.error;
    }
  }

  Future<void> contractView() async {
    isContractLoading.value = Status.loading;
    try {
      Utils().logInfo("Fetching contract data...");
      final data = await homeRepo.contractViewRepo();

      if (data != null) {
        Utils().logInfo("Contract data received: ${data.toString()}");
        contractDataModel.value = data;
        isContractLoading.value = Status.success;
      } else {
        Utils().logError(
            "Contract data is null - check repository logs for details");
      }
    } catch (error) {
      Utils().logError(
        'Error getting contract: $error',
      );
    } finally {
      isContractLoading.value = Status.success;
    }
  }

  Future<void> invoiceList() async {
    isInvoiceLoading.value = Status.loading;
    try {
      Utils().logInfo("Fetching invoice data...");
      final data = await homeRepo.myInvoiceRepo();

      if (data.isNotEmpty) {
        Utils().logInfo("Invoice data received successfully");
        invoiceListDataModel.value = data;
        isInvoiceLoading.value = Status.success;
      } else {
        Utils().logInfo("No invoice data found");
        invoiceListDataModel.value = [];
        isInvoiceLoading.value = Status.success;
      }
    } catch (error) {
      Utils().logError('Error fetching invoices: $error');
      isInvoiceLoading.value = Status.error;
      Get.snackbar(
        'Error',
        'Failed to load invoices. Please try again.',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
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
    getCustomerDashborad();
    getRattingData();
    contractView();
    invoiceList();
    shipController.fetchShipmentData('0');
    super.onInit();
  }
}
