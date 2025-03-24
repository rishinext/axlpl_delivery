import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/const/const.dart';
import 'package:axlpl_delivery/utils/utils.dart';

class AddShipmentRepo {
  final ApiServices _apiServices = ApiServices();

  Future<List<CustomersList>?> customerListRepo(
      final search, final nextID) async {
    try {
      final userData = await LocalStorage().getUserLocalData();
      final userID = userData?.messangerdetail?.id?.toString();
      final branchID = userData?.messangerdetail?.branchId;
      final token = userData?.messangerdetail?.token;
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
      Utils().logError("$e", 'Customers Failed: $e');
    }
    return null;
  }

  Future<List<CategoryList>?> categoryListRepo(
    final search,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token = userData?.messangerdetail?.token;

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
      Utils().logError("$e", 'CategoryList Failed: $e');
    }
    return null;
  }

  Future<List<CommodityList>?> commodityListRepo(
    final search,
    final categoryID,
  ) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token = userData?.messangerdetail?.token;

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
      Utils().logError("$e", 'CategoryList Failed: $e');
    }
    return null;
  }

  Future<List<ServiceTypeList>?> serviceTypeListRepo() async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token = userData?.messangerdetail?.token;

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
      Utils().logError("$e", 'ServiceTypeList Failed: $e');
    }
    return null;
  }

  Future<GetPincodeDetailsModel?> pincodeDetailsRepo(String pincode) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token = userData?.messangerdetail?.token;

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
      Utils().logError("$e", 'Pincode Failed: $e');
    }
    return null;
  }

  Future<List<AreaList>?> allAeraByZipRepo(final pincode) async {
    try {
      final userData = await LocalStorage().getUserLocalData();

      final token = userData?.messangerdetail?.token;

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
      Utils().logError("$e", 'Area Failed: $e');
    }
    return null;
  }
}
