import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/nature_business_model.dart';
import 'package:axlpl_delivery/app/data/models/register_cate_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class CustomerRegisterRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<RegisterCategoryList>?> registerCateRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getCustomerCategory(token.toString());
      return response.when(
        success: (body) {
          final data = RegisterCategoryModel.fromJson(body);
          if (data.status == success) {
            return data.categories ?? [];
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${data.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("Register Category Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<List<NatureOfBusiness>?> registerNatureBusinessRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getNatureOfBusiness(token.toString());
      return response.when(
        success: (body) {
          final data = NatureOfBusniessModel.fromJson(body);
          if (data.status == success) {
            return data.natureOfBusiness ?? [];
          } else {
            Utils().logInfo(
                'API call successful but status is not "success" : ${data.status}');
          }
          return [];
        },
        error: (error) {
          throw Exception("BusinessList Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError(
        "$e",
      );
    }
    return null;
  }

  Future<GetPincodeDetailsModel?> pincodeDetailsRegisterRepo(
      String pincode) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token =
          userData?.messangerdetail?.token ?? userData?.customerdetail?.token;

      final response = await _apiServices.getPincodeDetailsRegister(
        token.toString(),
      );
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

  Future<List<AreaList>?> allAeraByZipRegisterRepo(final pincode) async {
    try {
      final response = await _apiServices.getAllAeraByZipRegistration(pincode);
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

  Future<void> customerRegisterRepo(
    final companyName,
    final fullName,
    final categoryID,
    final natureBusinessID,
    final email,
    final mobile,
    final telephone,
    final faxNo,
    final gstNo,
    final panNo,
    final axlplInsuranceValue,
    final thirdPartyInsuranceValue,
    final thirdPartyPolicyNo,
    final thirdPartyExpDate,
    final password,
    final countryID,
    final stateID,
    final cityID,
    final areaID,
    final pincode,
    final address1,
    final address2,
    final uploadProfile,
    final uploadGst,
    final uploadPan,
  ) async {
    try {
      final response = await _apiServices.customerRegister(
        companyName,
        fullName,
        categoryID,
        natureBusinessID,
        email,
        mobile,
        telephone,
        faxNo,
        gstNo,
        panNo,
        axlplInsuranceValue,
        thirdPartyInsuranceValue,
        thirdPartyPolicyNo,
        thirdPartyExpDate,
        password,
        countryID,
        stateID,
        cityID,
        areaID,
        pincode,
        address1,
        address2,
        uploadProfile,
        uploadGst,
        uploadPan,
      );

      response.when(
        success: (body) {
          final data = body;
          if (data['status'] == 'success') {
            log(data['message'] ?? 'Registration Successful');
          } else {
            throw Exception(data['message'] ?? 'Registration Failed');
          }
        },
        error: (error) {
          throw Exception("Register Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      Utils().logError("Registration Error: $e");
      rethrow; // Re-throw to handle in controller
    }
  }
}
