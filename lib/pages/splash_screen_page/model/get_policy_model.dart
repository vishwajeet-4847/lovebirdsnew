import 'dart:convert';

GetPolicyModel getCountryModelFromJson(String str) => GetPolicyModel.fromJson(json.decode(str));

String getCountryModelToJson(GetPolicyModel data) => json.encode(data.toJson());

class GetPolicyModel {
  bool? status;
  String? message;
  GetPolicyData? data;

  GetPolicyModel({this.status, this.message, this.data});

  GetPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GetPolicyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetPolicyData {
  String? privacyPolicyLink;
  String? termsOfUsePolicyLink;

  GetPolicyData({this.privacyPolicyLink, this.termsOfUsePolicyLink});

  GetPolicyData.fromJson(Map<String, dynamic> json) {
    privacyPolicyLink = json['privacyPolicyLink'];
    termsOfUsePolicyLink = json['termsOfUsePolicyLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['privacyPolicyLink'] = privacyPolicyLink;
    data['termsOfUsePolicyLink'] = termsOfUsePolicyLink;
    return data;
  }
}
