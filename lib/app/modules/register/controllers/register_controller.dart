import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/nature_business_model.dart';
import 'package:axlpl_delivery/app/data/models/register_cate_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/add_shipment_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/customer_register_repo.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final registerRepo = CustomerRegisterRepo();
  final addShipmentRepo = AddShipmentRepo();

  var registerCategoryList = <RegisterCategoryList>[].obs;

  var registerNatureBusinessList = <NatureOfBusiness>[].obs;

  final areaList = <AreaList>[].obs;

  final PageController pageController = PageController();

  var selectedCategory = Rxn<RegisterCategoryList>();

  var selectedNatureBusiness = Rxn<NatureOfBusiness>();

  var pincodeDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var pincodeReceiverDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var areaDetailsData = Rxn<GetPincodeDetailsModel>(null);
  var pincodeDataDiff = Rxn<GetPincodeDetailsModel>(null);
  var selectedSenderArea = Rxn();
  final isLoadingCate = false.obs;

  final isNatureBusinessLoading = false.obs;
  final isLoadingPincode = false.obs;
  final isLoadingArea = false.obs;

  var selectedSenderStateId = 0.obs;
  var selectedSenderCityId = 0.obs;
  var selectedSenderAreaId = 0.obs;

  Rx<DateTime> date = DateTime.now().obs;

  final errorMessage = RxString('');

  var panFile = Rx<File?>(null);
  var gstFile = Rx<File?>(null);
  List<GlobalKey<FormState>> formKeys =
      List.generate(2, (index) => GlobalKey<FormState>());
  var currentPage = 0.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> pickDate(BuildContext context, [final selectDate]) async {
    final DateTime? pickedDate = await holoDatePicker(
      context,
      initialDate: selectDate.value,
      firstDate: DateTime(2000), // Adjust as needed
      lastDate: DateTime(2100), // Adjust as needed
      hintText: "Choose Start Date",
    );

    if (pickedDate != null && pickedDate != selectDate.value) {
      selectDate.value = pickedDate; // Update the selected date
    }
  }

  Future<void> fetchRegisterCate() async {
    try {
      isLoadingCate(true);
      final data = await registerRepo.registerCateRepo();
      registerCategoryList.value = data ?? [];
    } catch (e) {
      registerCategoryList.value = [];
      Utils().logError(
        'customer cate fetch failed $e',
      );
    } finally {
      isLoadingCate(false);
    }
  }

  Future<void> fetchNatureBusiness() async {
    try {
      isNatureBusinessLoading(true);
      final data = await registerRepo.registerNatureBusinessRepo();
      registerNatureBusinessList.value = data ?? [];
    } catch (e) {
      registerNatureBusinessList.value = [];
      Utils().logError(
        'Nature of business fetch failed $e',
      );
    } finally {
      isNatureBusinessLoading(false);
    }
  }

  Future<void> fetchPincodeDetails(String pincode) async {
    errorMessage.value = '';
    try {
      isLoadingPincode.value = true;

      final response = await addShipmentRepo.pincodeDetailsRepo(pincode);

      if (response != null &&
          response.stateName != null &&
          response.cityName != null) {
        pincodeDetailsData.value = response;
        pincodeReceiverDetailsData.value = response;
      } else {
        pincodeDetailsData.value = null; // clear invalid data
        pincodeReceiverDetailsData.value = null;
        errorMessage.value = 'Invalid pincode!';
      }
    } catch (e) {
      pincodeDetailsData.value = null;
      pincodeReceiverDetailsData.value = null;
      errorMessage.value = 'Pincode fetch failed!';
      Utils().logError(
        'Pincode Fetch Failed $e',
      );
    } finally {
      isLoadingPincode.value = false;
    }
  }

  Future fetchAera(final zip) async {
    if (zipController.text.isEmpty) return;
    try {
      isLoadingArea(true);

      areaList.value = [];
      final data = await addShipmentRepo.allAeraByZipRepo(zip);
      if (data == null || data.isEmpty) {
        areaList.value = [];

        Utils().logInfo('No Aera found ${zipController.text}');
        return;
      } else {
        areaList.value = data;
      }
      areaList.value = data;
    } catch (error) {
      areaList.value = [];
      Utils().logError(
        'Error getting customers $error',
      );
    } finally {
      isLoadingArea(false);
    }
  }

  @override
  void onInit() {
    fetchRegisterCate();
    fetchNatureBusiness();
    super.onInit();
  }
}
