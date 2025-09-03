import 'dart:developer';
import 'dart:io';

import 'package:axlpl_delivery/app/data/models/category&comodity_list_model.dart';
import 'package:axlpl_delivery/app/data/models/get_pincode_details_model.dart';
import 'package:axlpl_delivery/app/data/models/nature_business_model.dart';
import 'package:axlpl_delivery/app/data/models/register_cate_model.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/add_shipment_repo.dart';
import 'package:axlpl_delivery/app/data/networking/repostiory/customer_register_repo.dart';
import 'package:axlpl_delivery/app/routes/app_pages.dart';
import 'package:axlpl_delivery/common_widget/common_datepicker.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final registerRepo = CustomerRegisterRepo();
  final addShipmentRepo = AddShipmentRepo();
  final formKey = GlobalKey<FormState>();

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

  final isRegistered = false.obs;
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
  var profileImg = Rx<File?>(null);

  List<GlobalKey<FormState>> formKeys =
      List.generate(2, (index) => GlobalKey<FormState>());
  var currentPage = 0.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController telePhoneController = TextEditingController();
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
  TextEditingController thirdPartyInsuranceController = TextEditingController();
  TextEditingController thirdPartyPolicyController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController thirdDateController = TextEditingController();

  var branchID;

  bool _validateRequiredFields() {
    return companyNameController.text.trim().isNotEmpty &&
        fullNameController.text.trim().isNotEmpty &&
        selectedCategory.value != null &&
        selectedNatureBusiness.value != null &&
        branchID != null &&
        branchID!.isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        mobileController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        selectedSenderStateId.value > 0 &&
        selectedSenderCityId.value > 0 &&
        zipController.text.trim().isNotEmpty &&
        address1Controller.text.trim().isNotEmpty &&
        address2Controller.text.trim().isNotEmpty;
  }

  Future<void> register() async {
    print('=== DEBUGGING REGISTRATION FIELDS ===');
    print('company_name: "${companyNameController.text}"');
    print('full_name: "${fullNameController.text}"');
    print('category: "${selectedCategory.value?.name?.toString() ?? ''}"');
    print(
        'nature_of_business: "${selectedNatureBusiness.value?.name?.toString() ?? ''}"');
    print('email_address: "${emailController.text}"');
    print('mobile_no: "${mobileController.text}"');
    print('password: "${passwordController.text}"');
    print('state_id: "${selectedSenderStateId.value.toString()}"');
    print('city_id: "${selectedSenderCityId.value.toString()}"');
    print('pincode: "${zipController.text}"');
    print('registered_address1: "${address1Controller.text}"');
    print('registered_address2: "${address2Controller.text}"');
    print('=====================================');

    print('=== FILE DEBUG ===');
    print('profileImg.value: ${profileImg.value}');
    print('panFile.value: ${panFile.value}');
    print('gstFile.value: ${gstFile.value}');
    print('==================');

    // Validate only REQUIRED files (GST and PAN)
    if (panFile.value == null) {
      Get.snackbar('Error', 'Please select PAN card file');
      return;
    }

    if (gstFile.value == null) {
      Get.snackbar('Error', 'Please select GST file');
      return;
    }

    // Validate required text fields
    if (companyNameController.text.trim().isEmpty ||
        fullNameController.text.trim().isEmpty ||
        selectedCategory.value?.name == null ||
        selectedNatureBusiness.value?.name == null ||
        emailController.text.trim().isEmpty ||
        mobileController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        selectedSenderStateId.value <= 0 ||
        selectedSenderCityId.value <= 0 ||
        zipController.text.trim().isEmpty ||
        address1Controller.text.trim().isEmpty ||
        address2Controller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill in all required fields');
      return;
    }

    isRegistered(true);
    try {
      await registerRepo.customerRegisterRepo(
        companyNameController.text.trim(),
        fullNameController.text.trim(),
        selectedCategory.value?.name?.toString() ?? '', // Use ID not name
        selectedNatureBusiness.value?.name?.toString() ?? '', // Use ID not name
        emailController.text.trim(),
        mobileController.text.trim(),
        telePhoneController.text.trim(),
        faxController.text.trim(),
        gstController.text.trim(),
        panController.text.trim(),
        insuranceController.text.trim(),
        thirdPartyInsuranceController.text.trim(),
        thirdPartyPolicyController.text.trim(),
        thirdDateController.text.trim(),
        passwordController.text.trim(),
        '1', // country_id
        selectedSenderStateId.value.toString(),
        selectedSenderCityId.value.toString(),
        selectedSenderAreaId.value.toString(),
        zipController.text.trim(),
        address1Controller.text.trim(),
        address2Controller.text.trim(),
        profileImg.value, // Optional - can be null
        gstFile.value, // Required
        panFile.value, // Required
      );

      isRegistered(false);
      Get.snackbar('Success', 'Registration completed successfully!',
          backgroundColor: themes.darkCyanBlue, colorText: themes.whiteColor);
      Get.toNamed(Routes.AUTH);
    } catch (e) {
      isRegistered(false);
      print('Registration Error: $e');
      Get.snackbar('Error', 'Registration failed: ${e.toString()}',
          backgroundColor: themes.redColor, colorText: themes.whiteColor);
    }
  }

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

      final response = await registerRepo.pincodeDetailsRegisterRepo(
        pincode,
      );

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
      final data = await registerRepo.allAeraByZipRegisterRepo(zip);
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
