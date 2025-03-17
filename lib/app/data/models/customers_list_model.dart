class CustomerListModel {
  String? status;
  String? message;
  List<CustomersList>? customers;
  List<Next>? next;

  CustomerListModel({this.status, this.message, this.customers, this.next});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Customers'] != null) {
      customers = <CustomersList>[];
      json['Customers'].forEach((v) {
        customers!.add(CustomersList.fromJson(v));
      });
    }
    if (json['next'] != null) {
      next = <Next>[];
      json['next'].forEach((v) {
        next!.add(Next.fromJson(v));
      });
    }
  }
}

class CustomersList {
  String? id;
  String? companyName;
  String? fullName;
  String? branchId;
  String? mobileNo;
  String? email;
  String? axlplInsuranceValue;
  String? thirdPartyInsuranceValue;
  String? thirdPartyPolicyNo;
  String? thirdPartyExpDate;
  String? countryId;
  String? countryName;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  String? areaId;
  String? areaName;
  String? pincode;
  String? address1;
  String? address2;
  String? gstNo;

  CustomersList(
      {this.id,
      this.companyName,
      this.fullName,
      this.branchId,
      this.mobileNo,
      this.email,
      this.axlplInsuranceValue,
      this.thirdPartyInsuranceValue,
      this.thirdPartyPolicyNo,
      this.thirdPartyExpDate,
      this.countryId,
      this.countryName,
      this.stateId,
      this.stateName,
      this.cityId,
      this.cityName,
      this.areaId,
      this.areaName,
      this.pincode,
      this.address1,
      this.address2,
      this.gstNo});

  CustomersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    fullName = json['full_name'];
    branchId = json['branch_id'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    axlplInsuranceValue = json['axlpl_insurance_value'];
    thirdPartyInsuranceValue = json['third_party_insurance_value'];
    thirdPartyPolicyNo = json['third_party_policy_no'];
    thirdPartyExpDate = json['third_party_exp_date'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    pincode = json['pincode'];
    address1 = json['address1'];
    address2 = json['address2'];
    gstNo = json['gst_no'];
  }
}

class Next {
  String? total;
  String? nextId;

  Next({this.total, this.nextId});

  Next.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    nextId = json['next_id'];
  }
}
