import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/customers_list_model.dart';
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

      if (userID?.isNotEmpty == true || userID != null) {
        final response = await _apiServices.getCustomersList(
            userID.toString(), branchID.toString(), search, nextID);
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
}
