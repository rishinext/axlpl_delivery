import 'package:axlpl_delivery/app/data/models/history_delivery_model.dart';
import 'package:axlpl_delivery/app/data/models/transtion_history_model.dart';
import 'package:axlpl_delivery/app/data/networking/data_state.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/cash_coll_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/delivery_repo.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/history_pickup_model.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final historyRepo = DeliveryRepo(); // assuming you have a repository class
  final cashLogRepo =
      CashCollectionRepository(); // assuming you have a repository class
  final historyList = <HistoryDelivery>[].obs;
  final pickUpHistoryList = <HistoryPickup>[].obs;
  final cashCollList = <CashLog>[].obs;
  final filteredCashCollList = <CashLog>[].obs;

  final zipcodeController = TextEditingController();
  final dateFilterController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  RxInt isSelected = 0.obs;
  var isDeliveredLoading = Status.initial.obs;
  var isPickedup = Status.initial.obs;
  var isCashCollLoading = Status.initial.obs;

  void selectedContainer(int index) {
    isSelected.value = index;
  }

  Future<void> getDeliveryHistory({final nextID = '0', final zip = '0'}) async {
    isDeliveredLoading.value = Status.loading;

    try {
      final success = await historyRepo.deliveryHistoryRepo(
        zip,
        nextID,
      );

      if (success != null && success.isNotEmpty) {
        historyList.value = success;
        isDeliveredLoading.value = Status.success;
      } else {
        Utils().logInfo('No Delivery History Data Found');
        historyList.value = [];
        isDeliveredLoading.value = Status.error;
      }
    } catch (error) {
      Utils().logError(
        'Error getting history $error',
      );
      historyList.value = [];
      isDeliveredLoading.value = Status.error;
    }
  }

  Future<void> getPickupHistory() async {
    isPickedup.value = Status.loading;

    try {
      final success = await historyRepo.pickupHistoryRepo();

      if (success != null && success.isNotEmpty) {
        pickUpHistoryList.value = success;
        isPickedup.value = Status.success;
      } else {
        Utils().logInfo('No Pickup History Data Found');
        pickUpHistoryList.value = [];
        isPickedup.value = Status.error;
      }
    } catch (error) {
      Utils().logError(
        'Error getting pickup history $error',
      );
      pickUpHistoryList.value = [];
      isPickedup.value = Status.error;
    }
  }

  Future<void> getCashCollectionHistory() async {
    isCashCollLoading.value = Status.loading;
    Utils().logInfo('Starting to fetch cash collection history...');

    try {
      final success = await cashLogRepo.cashCollRepo('0');
      Utils().logInfo(
          'Cash collection API response: ${success?.length ?? 0} items');

      if (success != null && success.isNotEmpty) {
        cashCollList.value = success;
        filteredCashCollList.value = success; // Initialize filtered list
        isCashCollLoading.value = Status.success;
        Utils().logInfo(
            'Cash collection history loaded successfully: ${success.length} items');
      } else {
        Utils().logInfo('No Cash Collection History Data Found');
        cashCollList.value = [];
        filteredCashCollList.value = [];
        isCashCollLoading.value = Status.error;
      }
    } catch (error) {
      Utils().logError(
        'Error getting cash collection history $error',
      );
      cashCollList.value = [];
      filteredCashCollList.value = [];
      isCashCollLoading.value = Status.error;
    }
  }

  void filterCashCollectionByDate(String dateInput) {
    if (dateInput.isEmpty) {
      // If no date input, show all data
      filteredCashCollList.value = cashCollList;
      Utils()
          .logInfo('Filter cleared - showing all ${cashCollList.length} items');
      return;
    }

    try {
      // Parse the input date (expecting DD/MM/YYYY format)
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      DateTime filterDate = inputFormat.parse(dateInput);

      // Filter the cash collection list
      filteredCashCollList.value = cashCollList.where((cash) {
        if (cash.createdDate != null) {
          try {
            DateTime cashDate = DateTime.parse(cash.createdDate.toString());
            // Compare only the date part (ignore time)
            return cashDate.year == filterDate.year &&
                cashDate.month == filterDate.month &&
                cashDate.day == filterDate.day;
          } catch (e) {
            return false;
          }
        }
        return false;
      }).toList();

      Utils().logInfo(
          'Filtered by date $dateInput - found ${filteredCashCollList.length} items');
    } catch (e) {
      // If date parsing fails, show all data
      filteredCashCollList.value = cashCollList;
      Utils().logError('Invalid date format: $e');
    }
  }

  void clearDateFilter() {
    Utils().logInfo('Clear date filter button pressed');
    dateFilterController.clear();
    filteredCashCollList.value =
        List.from(cashCollList); // Force reactive update
    filteredCashCollList.refresh(); // Explicitly refresh the observable
    Utils()
        .logInfo('Date filter cleared - showing ${cashCollList.length} items');
    Utils().logInfo(
        'Text field value after clear: "${dateFilterController.text}"');
  }

  void filterCashCollectionByDateRange() {
    String fromDateText = fromDateController.text.trim();
    String toDateText = toDateController.text.trim();

    Utils()
        .logInfo('Filtering by date range: From=$fromDateText, To=$toDateText');

    // If both dates are empty, show all data
    if (fromDateText.isEmpty && toDateText.isEmpty) {
      filteredCashCollList.value = List.from(cashCollList);
      Utils().logInfo(
          'No date range specified - showing all ${cashCollList.length} items');
      return;
    }

    try {
      DateFormat inputFormat = DateFormat('dd/MM/yyyy');
      DateTime? fromDate;
      DateTime? toDate;

      // Parse from date if provided
      if (fromDateText.isNotEmpty) {
        fromDate = inputFormat.parse(fromDateText);
      }

      // Parse to date if provided
      if (toDateText.isNotEmpty) {
        toDate = inputFormat.parse(toDateText);
        // Set to end of day for inclusive filtering
        toDate = DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59);
      }

      // Filter the cash collection list
      filteredCashCollList.value = cashCollList.where((cash) {
        if (cash.createdDate != null) {
          try {
            DateTime cashDate = DateTime.parse(cash.createdDate.toString());

            // Check from date condition
            if (fromDate != null && cashDate.isBefore(fromDate)) {
              return false;
            }

            // Check to date condition
            if (toDate != null && cashDate.isAfter(toDate)) {
              return false;
            }

            return true;
          } catch (e) {
            return false;
          }
        }
        return false;
      }).toList();

      Utils().logInfo(
          'Date range filter applied - found ${filteredCashCollList.length} items');
    } catch (e) {
      // If date parsing fails, show all data
      filteredCashCollList.value = List.from(cashCollList);
      Utils().logError('Invalid date format in range filter: $e');
    }
  }

  void clearDateRangeFilter() {
    Utils().logInfo('Clear date range filter pressed');
    fromDateController.clear();
    toDateController.clear();
    filteredCashCollList.value = List.from(cashCollList);
    filteredCashCollList.refresh();
    Utils().logInfo(
        'Date range filter cleared - showing ${cashCollList.length} items');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getDeliveryHistory();
    getPickupHistory();
    getCashCollectionHistory();
    super.onInit();
  }
}
