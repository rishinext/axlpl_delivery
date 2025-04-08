import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
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
    final cateID,
    final productID,
    final netWeight,
    final grossWeight,
    final paymentModeID,
    final serviceTypeID,
    final policyNo,
    final expDate,
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
    final String? custID = userData.customerdetail?.id.toString();
    final String? token = userData.messangerdetail?.token.toString() ??
        userData.customerdetail?.token.toString();

    final String? userID = mId ?? custID;
    if (userID == null || role == null || token == null) {
      Utils().logInfo('Logout skipped - user data incomplete');
      return false;
    }
    try {
      final response = await _apiServices.addShipment(
        custID,
        cateID,
        productID,
        netWeight,
        grossWeight,
        paymentModeID,
        serviceTypeID,
        policyNo,
        expDate,
        invoiceAmt,
        insurance,
        addInsurance,
        shipmentStatus,
        caculationStatus,
        addedBy,
        addedType,
        alertShipment,
        shipmentInvoice,
        isAmtEditedByUser,
        shipmentID,
        senderName,
        senderCompanyName,
        senderCountry,
        senderState,
        senderCity,
        senderAera,
        senderPincode,
        senderAddress1,
        senderAddress2,
        senderMobile,
        senderEmail,
        senderSaveAddress,
        senderisNewAdresss,
        senderGstNo,
        senderCustID,
        receiverName,
        remark,
        billTo,
        noOfParcel,
        receiverCompanyName,
        receiverCountry,
        receiverState,
        receiverCity,
        receiverAera,
        receiverPincode,
        receiverAddress1,
        receiverAddress2,
        receiverMobile,
        receiverEmail,
        receiverSaveAddress,
        receiverisNewAdresss,
        receiverGstNo,
        receiverCustID,
        isDiffAdd,
        diffReceiverCountry,
        diffReceiverState,
        diffReceiverCity,
        diffReceiverAera,
        diffReceiverPincode,
        diffReceiverAddress1,
        diffReceiverAddress2,
        shipmentCharges,
        insuranceCharges,
        invoiceCharges,
        handlingCharges,
        tax,
        totalCharges,
        grandeTotal,
        docketNo,
        shipmentDate,
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
}
