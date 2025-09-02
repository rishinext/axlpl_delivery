import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/models/contract_details_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_cal_model.dart';
import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class AddShipmentRepo {
  final ApiServices _apiServices = ApiServices();
  final Utils _utils = Utils();
  final LocalStorage _localStorage = LocalStorage();
  Future<List<CustomersList>?> customerListRepo(
      final search, final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString() ??
          userData?.customerdetail?.id.toString();
      final branchID = userData?.messangerdetail?.branchId ??
          userData?.customerdetail?.branchId.toString();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;
      if (userID != null && userID.isNotEmpty) {
        final response = await _apiServices.getCustomersList(userID.toString(),
            branchID.toString(), search, nextID, token.toString());
        return response.when(
          success: (body) {
            final customersData = CustomerListModel.fromJson(body);
            if (customersData.status == success) {
              return customersData.customers;
            } else {
              Utils().logInfo(
                  'API call successful but status is not "success" : ${customersData.status}');
            }
            return [];
          },
          error: (error) {
            throw Exception("Customers Failed: ${error.toString()}");
          },
        );
      }
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<CategoryList>?> categoryListRepo(
    final search,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response =
          await _apiServices.getCategoryList(search, token.toString());
      return response.when(
        success: (body) {
          final categoryData = CategoryListModel.fromJson(body);
          if (categoryData.status == success) {
            return categoryData.category;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${categoryData.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("CategoryList Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<CommodityList>?> commodityListRepo(
    final search,
    final categoryID,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getCommodityList(
          search, categoryID, token.toString());
      return response.when(
        success: (body) {
          final commodityData = CategoryListModel.fromJson(body);
          if (commodityData.status == success) {
            return commodityData.comodityList;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${commodityData.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("CategoryList Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<ServiceTypeList>?> serviceTypeListRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getServiceTypeList(token.toString());
      return response.when(
        success: (body) {
          final serviceTypeData = CategoryListModel.fromJson(body);
          if (serviceTypeData.status == success) {
            return serviceTypeData.servicesList;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${serviceTypeData.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("ServiceTypeList Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<GetPincodeDetailsModel?> pincodeDetailsRepo(String pincode) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response =
          await _apiServices.getPincodeDetails(token.toString(), pincode);
      return response.when(
        success: (body) {
          final pincodeDetailsData = GetPincodeDetailsModel.fromJson(body);
          if (pincodeDetailsData.status == success) {
            return pincodeDetailsData;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${pincodeDetailsData.status}');
          }
          return null;
        },
        error: (error) {
          throw Exception("Pincode Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError("$e");
    }
    return null;
  }

  Future<List<AreaList>?> allAeraByZipRepo(final pincode) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response =
          await _apiServices.getAllAeraByZip(token.toString(), pincode);
      return response.when(
        success: (body) {
          final aeraData = CategoryListModel.fromJson(body);
          if (aeraData.status == success) {
            return aeraData.areaList;
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${aeraData.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("Aera Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<bool?> addShipmentRepo({
    required ShipmentModel shipmentModel,
  }) async {
    final userData = await LocalStorage().getUserLocalData();
    if (userData == null) return false;

    final String? role = userData.role;
    final String? userID = userData.messangerdetail?.id?.toString() ??
        userData.customerdetail?.id?.toString();

    final String? token = userData.messangerdetail?.token?.toString() ??
        userData.customerdetail?.token?.toString();

    if (userID == null || role == null || token == null) {
      return false;
    }

    try {
      final response = await _apiServices.addShipment(
        shipmentModel: shipmentModel,
        token: token,
      );

      response.when(
        success: (success) {
          log("Shipment Add Success: ${response.toString()}");
        },
        error: (error) {
          throw Exception("Shipment add failed: ${error.toString()}");
        },
      );

      return true;
    } catch (e) {
      _utils.logError(e.toString());
      return false;
    }
  }

  Future<List<PaymentInformation>?> shipmentCalculationRepo(
    final custID,
    final cateID,
    final commID,
    final netWeight,
    final grossWeight,
    final paymentMode,
    final invoiceValue,
    final insuranceByAxlpl,
    final policyNo,
    final numberOfParcel,
    final expDate,
    final policyValue,
    final senderZip,
    final receiverZip,
  ) async {
    try {
      final response = await _apiServices.getShipmentCalculation(
        custID,
        cateID,
        commID,
        netWeight,
        grossWeight,
        paymentMode,
        invoiceValue,
        insuranceByAxlpl,
        policyNo,
        numberOfParcel,
        expDate,
        policyValue,
        senderZip,
        receiverZip,
      );

      return response.when(
        success: (body) {
          final grossCal = ShipmentCalModel.fromJson(body);
          if (grossCal.status == success) {
            return grossCal.paymentInformation;
          } else {
            Utils().logInfo(grossCal.message.toString());
          }
          return [];
        },
        error: (error) {
          throw Exception("Gross Calculation API Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(e.toString());
    }
    return null;
  }

  Future<List<Contract>> getContractDetailsRepo(
    final customerID,
    final categoryID,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getContractDetails(
        customerID,
        categoryID,
        token?.toString() ?? '',
      );

      // Capture the result outside the callback and RETURN it.
      return response.when(
        success: (body) {
          final model =
              ContractsDeatilsModel.fromJson(body); // (fix typo if needed)
          // Compare against the actual success value (string or enum)
          final isOk = (model.status == 'success') ||
              (model.status == Status.success.name);
          if (isOk) {
            return model.contracts ?? <Contract>[];
          } else {
            Utils().logInfo(
              'API call ok but status not "success": ${model.status}',
            );
            return <Contract>[];
          }
        },
        error: (err) {
          Utils().logError('Contract Details Failed: $err');
          return <Contract>[];
        },
      );
    } catch (e) {
      Utils().logError('getContractDetailsRepo exception: $e');
      return <Contract>[];
    }
  }
}
