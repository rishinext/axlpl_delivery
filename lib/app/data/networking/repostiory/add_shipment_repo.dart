import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/common_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
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

  Future<bool?> addShipment(
    final custID,
    final cateID,
    final commodityID,
    final netWeight,
    final grossWeight,
    final paymentModeID,
    final serviceTypeID,
    final policyNo,
    final expDate,
    final insuraceValue,
    final invoiceAmt,
    final insurance,
    final addInsurance,
    final shipmentStatus,
    final caculationStatus,
    final addedBy,
    final addedType,
    final alertShipment,
    final shipmentInvoice,
    final isAmtEditedByUser,
    final shipmentID,
    final senderName,
    final senderCompanyName,
    final senderCountry,
    final senderState,
    final senderCity,
    final senderAera,
    final senderPincode,
    final senderAddress1,
    final senderAddress2,
    final senderMobile,
    final senderEmail,
    final senderSaveAddress,
    final senderisNewAdresss,
    final senderGstNo,
    final senderCustID,
    final receiverName,
    final remark,
    final billTo,
    final noOfParcel,
    final receiverCompanyName,
    final receiverCountry,
    final receiverState,
    final receiverCity,
    final receiverAera,
    final receiverPincode,
    final receiverAddress1,
    final receiverAddress2,
    final receiverMobile,
    final receiverEmail,
    final receiverSaveAddress,
    final receiverisNewAdresss,
    final receiverGstNo,
    final receiverCustID,
    final isDiffAdd,
    final diffReceiverCountry,
    final diffReceiverState,
    final diffReceiverCity,
    final diffReceiverAera,
    final diffReceiverPincode,
    final diffReceiverAddress1,
    final diffReceiverAddress2,
    final shipmentCharges,
    final insuranceCharges,
    final invoiceCharges,
    final handlingCharges,
    final tax,
    final totalCharges,
    final grandeTotal,
    final docketNo,
    final shipmentDate,
  ) async {
    final userData = await LocalStorage().getUserLocalData();
    if (userData == null) return false;
    final String? role = userData.role;
    final String? mId = userData.messangerdetail?.id?.toString();
    // final String? custID = userData.customerdetail?.id.toString() ??
    //     userData.messangerdetail?.id.toString();
    final String? token = userData.messangerdetail?.token.toString() ??
        userData.customerdetail?.token.toString();

    final String? userID = mId ?? custID;
    if (userID == null || role == null || token == null) {
      Utils().logInfo('Logout skipped - user data incomplete');
      return false;
    }
    try {
      final response = await _apiServices.addShipment(
        custID, // 1
        cateID, // 2
        commodityID, // 3
        netWeight, // 4
        grossWeight, // 5
        paymentModeID, // 6
        serviceTypeID, // 7 - add this if missing
        policyNo, // 8
        expDate, // 9
        invoiceAmt, // 10
        insurance, // 11
        addInsurance, // 12
        shipmentStatus, // 13
        caculationStatus, // 14
        addedBy, // 15
        addedType, // 16
        alertShipment, // 17
        shipmentInvoice, // 18
        isAmtEditedByUser, // 19
        shipmentID, // 20
        senderName, // 21
        senderCompanyName, // 22
        senderCountry, // 23
        senderState, // 24
        senderCity, // 25
        senderAera, // 26
        senderPincode, // 27
        senderAddress1, // 28
        senderAddress2, // 29
        senderMobile, // 30
        senderEmail, // 31
        senderSaveAddress, // 32
        senderisNewAdresss, // 33
        senderGstNo, // 34
        senderCustID, // 35
        receiverName, // 36
        remark,
        billTo,
        noOfParcel,
        receiverCompanyName, // 37
        receiverCountry, // 38
        receiverState, // 39
        receiverCity, // 40
        receiverAera, // 41
        receiverPincode, // 42
        receiverAddress1, // 43
        receiverAddress2, // 44
        receiverMobile, // 45
        receiverEmail, // 46
        receiverSaveAddress, // 47
        receiverisNewAdresss, // 48
        receiverGstNo, // 49
        receiverCustID, // 50
        isDiffAdd, // 51
        diffReceiverCountry, // 52
        diffReceiverState, // 53
        diffReceiverCity, // 54
        diffReceiverAera, // 55
        diffReceiverPincode, // 56
        diffReceiverAddress1, // 57
        diffReceiverAddress2, // 58
        shipmentCharges, // 59
        insuranceCharges, // 60
        invoiceCharges, //
        insuraceValue,
        handlingCharges, // 62
        tax, // 63
        totalCharges, // 64
        grandeTotal, // 65
        docketNo, // 66
        shipmentDate, // 67
        token.toString(),
      );
      response.when(
        success: (success) {
          log(response.toString());
        },
        error: (error) {
          throw Exception("shipment add Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      _utils.logError(e.toString());
    }
  }

  Future<bool?> grossCalculationRepo(
    String netWeight,
    String grossWeight,
    String status,
    String productID,
  ) async {
    try {
      final response = await _apiServices.grossCalculation(
        netWeight,
        grossWeight,
        status,
        productID,
      );

      return response.when(
        success: (body) {
          final grossCal = CommonModel.fromJson(body);
          if (grossCal.status == "fail") {
            // 🔥 fix check
            Utils().logInfo(grossCal.message.toString());
            return false; // fail condition
          } else {
            Utils().logInfo(grossCal.message.toString());
            return true; // success
          }
        },
        error: (error) {
          throw Exception("Gross Calculation API Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(e.toString());
      return null; // 🛡️ safe fallback
    }
  }
}
