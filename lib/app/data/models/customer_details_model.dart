// To parse this JSON data, do
//
//     final customerDetailsModel = customerDetailsModelFromJson(jsonString);

import 'dart:convert';

CustomerDetailsModel customerDetailsModelFromJson(String str) =>
    CustomerDetailsModel.fromJson(json.decode(str));

String customerDetailsModelToJson(CustomerDetailsModel data) =>
    json.encode(data.toJson());

class CustomerDetailsModel {
  CustomerdetailList? customerdetail;

  CustomerDetailsModel({
    this.customerdetail,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) =>
      CustomerDetailsModel(
        customerdetail: json["Customerdetail"] == null
            ? null
            : CustomerdetailList.fromJson(json["Customerdetail"]),
      );

  Map<String, dynamic> toJson() => {
        "Customerdetail": customerdetail?.toJson(),
      };
}

class CustomerdetailList {
  String? id;
  String? companyName;
  String? fullName;
  String? category;
  String? natureBusiness;
  String? countryId;
  String? stateId;
  String? cityId;
  String? areaId;
  String? branchId;
  String? countryName;
  String? stateName;
  String? cityName;
  String? areaName;
  String? branchName;
  String? regAddress1;
  String? regAddress2;
  String? pincode;
  String? mobileNo;
  String? telNo;
  String? faxNo;
  String? email;
  String? panNo;
  String? gstNo;
  String? regCerti;
  String? pOAttorney;
  String? telBill;
  String? panCard;
  String? gstCerti;
  String? custProfileImg;
  String? path;
  String? axlplInsuranceValue;
  String? thirdPartyInsuranceValue;
  String? thirdPartyPolicyNo;
  DateTime? thirdPartyExpDate;
  String? isShipmentApprove;
  String? isSendMail;
  String? isSendSms;
  String? token;

  CustomerdetailList({
    this.id,
    this.companyName,
    this.fullName,
    this.category,
    this.natureBusiness,
    this.countryId,
    this.stateId,
    this.cityId,
    this.areaId,
    this.branchId,
    this.countryName,
    this.stateName,
    this.cityName,
    this.areaName,
    this.branchName,
    this.regAddress1,
    this.regAddress2,
    this.pincode,
    this.mobileNo,
    this.telNo,
    this.faxNo,
    this.email,
    this.panNo,
    this.gstNo,
    this.regCerti,
    this.pOAttorney,
    this.telBill,
    this.panCard,
    this.gstCerti,
    this.custProfileImg,
    this.path,
    this.axlplInsuranceValue,
    this.thirdPartyInsuranceValue,
    this.thirdPartyPolicyNo,
    this.thirdPartyExpDate,
    this.isShipmentApprove,
    this.isSendMail,
    this.isSendSms,
    this.token,
  });

  factory CustomerdetailList.fromJson(Map<String, dynamic> json) =>
      CustomerdetailList(
        id: json["id"],
        companyName: json["company_name"],
        fullName: json["full_name"],
        category: json["category"],
        natureBusiness: json["nature_business"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        areaId: json["area_id"],
        branchId: json["branch_id"],
        countryName: json["country_name"],
        stateName: json["state_name"],
        cityName: json["city_name"],
        areaName: json["area_name"],
        branchName: json["branch_name"],
        regAddress1: json["reg_address1"],
        regAddress2: json["reg_address2"],
        pincode: json["pincode"],
        mobileNo: json["mobile_no"],
        telNo: json["tel_no"],
        faxNo: json["fax_no"],
        email: json["email"],
        panNo: json["pan_no"],
        gstNo: json["gst_no"],
        regCerti: json["reg_certi"],
        pOAttorney: json["p_o_attorney"],
        telBill: json["tel_bill"],
        panCard: json["pan_card"],
        gstCerti: json["gst_certi"],
        custProfileImg: json["cust_profile_img"],
        path: json["path"],
        axlplInsuranceValue: json["axlpl_insurance_value"],
        thirdPartyInsuranceValue: json["third_party_insurance_value"],
        thirdPartyPolicyNo: json["third_party_policy_no"],
        thirdPartyExpDate: json["third_party_exp_date"] == null
            ? null
            : DateTime.parse(json["third_party_exp_date"]),
        isShipmentApprove: json["is_shipment_approve"],
        isSendMail: json["is_send_mail"],
        isSendSms: json["is_send_sms"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "full_name": fullName,
        "category": category,
        "nature_business": natureBusiness,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "area_id": areaId,
        "branch_id": branchId,
        "country_name": countryName,
        "state_name": stateName,
        "city_name": cityName,
        "area_name": areaName,
        "branch_name": branchName,
        "reg_address1": regAddress1,
        "reg_address2": regAddress2,
        "pincode": pincode,
        "mobile_no": mobileNo,
        "tel_no": telNo,
        "fax_no": faxNo,
        "email": email,
        "pan_no": panNo,
        "gst_no": gstNo,
        "reg_certi": regCerti,
        "p_o_attorney": pOAttorney,
        "tel_bill": telBill,
        "pan_card": panCard,
        "gst_certi": gstCerti,
        "cust_profile_img": custProfileImg,
        "path": path,
        "axlpl_insurance_value": axlplInsuranceValue,
        "third_party_insurance_value": thirdPartyInsuranceValue,
        "third_party_policy_no": thirdPartyPolicyNo,
        "third_party_exp_date":
            "${thirdPartyExpDate!.year.toString().padLeft(4, '0')}-${thirdPartyExpDate!.month.toString().padLeft(2, '0')}-${thirdPartyExpDate!.day.toString().padLeft(2, '0')}",
        "is_shipment_approve": isShipmentApprove,
        "is_send_mail": isSendMail,
        "is_send_sms": isSendSms,
        "token": token,
      };
}
