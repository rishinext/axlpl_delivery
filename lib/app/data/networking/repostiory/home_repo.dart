import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/contract_view_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_details_model.dart';
import 'package:axlpl_delivery/app/data/models/customer_invoice_model.dart';
import 'package:axlpl_delivery/app/data/models/dashboard_model.dart';
import 'package:axlpl_delivery/app/data/models/get_ratting_model.dart';
import 'package:axlpl_delivery/app/data/models/used_contract_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/common_widget/my_invoices_list.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class HomeRepository {
  final ApiServices _apiServices = ApiServices();

  final LocalStorage _localStorage = LocalStorage();
  Future<DashboardDataModel?> dashboardDataRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        Utils().logInfo(
            "Calling API with: userID=$userID, branchID=$branchID, token=$token");

        final response = await _apiServices.getDashboardData(
          userID,
          branchID.toString(),
          token ?? "",
        );

        DashboardDataModel? result;

        response.when(
          success: (data) {
            final dashboardData = DashboardDataModel.fromJson(data);
            if (dashboardData.status == "success") {
              result = dashboardData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${dashboardData.status}');
            }
          },
          error: (error) {
            Utils().logError("API error: ${error.toString()}");
          },
        );

        return result;
      } else {
        Utils().logError("userID is null or empty");
      }
    } catch (e) {
      Utils().logError("dashboardDataRepo error: $e");
    }

    return null;
  }

  Future<CustomerDashboardDataModel?> customerDashboardDataRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.customerdetail?.id.toString();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getCustomerDashboardData(
          userID,
          token ?? "",
        );

        CustomerDashboardDataModel? result;

        response.when(
          success: (data) {
            final customerDashboardData =
                CustomerDashboardDataModel.fromJson(data);
            if (customerDashboardData.status == "success") {
              result = customerDashboardData;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${customerDashboardData.status}');
            }
          },
          error: (error) {
            Utils().logError("API error: ${error.toString()}");
          },
        );

        return result;
      } else {
        Utils().logError("userID is null or empty");
      }
    } catch (e) {
      Utils().logError("customerDashboardDataRepo error: $e");
    }

    return null;
  }

  Future<ContractViewModel?> contractViewRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.customerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final response = await _apiServices.contractView(userID);

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

  Future<UsedContractModel?> usedContractRepo(final contractID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.customerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final response = await _apiServices.usedContract(
        userID,
        contractID,
      );

      return response.when(
        success: (body) {
          final data = UsedContractModel.fromJson(body);
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

  Future<List<CustomerInvoiceModel?>> myInvoiceRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.customerdetail?.id?.toString();

      final response = await _apiServices.getCustomerInvoice(userID);

      return response.when(
        success: (body) {
          try {
            if (body is List) {
              // If response is directly a list
              return List<CustomerInvoiceModel>.from(body.map((x) =>
                  CustomerInvoiceModel.fromJson(x as Map<String, dynamic>)));
            } else if (body is Map<String, dynamic>) {
              // If response is wrapped in an object
              final data = CustomerInvoiceListModel.fromJson(body);
              if (data.status == 'success') {
                return data.data ?? [];
              }
            }
            Utils().logInfo('Unexpected response format: $body');
            return [];
          } catch (e) {
            Utils().logError('Error parsing invoice data: $e');
            return [];
          }
        },
        error: (error) {
          Utils().logError("Invoice Failed: ${error.toString()}");
          return [];
        },
      );
    } catch (e) {
      Utils().logError("$e");
      return [];
    }
  }

  Future<RattingDataModel?> getRattingRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getMessangerRatting(
          userID,
          token.toString(),
        );

        RattingDataModel? result;

        response.when(
          success: (body) {
            log("Raw response body: ${jsonEncode(body)}");
            result = RattingDataModel.fromJson(body); // ✅
          },
          error: (error) {
            Utils().logError("Ratting error: $error");
          },
        );

        return result;
      } else {
        Utils().logError("Missing user ID");
      }
    } catch (e) {
      Utils().logError("Exception in getRattingRepo: $e");
    }

    return null;
  }
}
