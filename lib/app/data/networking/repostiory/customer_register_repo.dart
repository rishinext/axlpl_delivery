import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
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
}
