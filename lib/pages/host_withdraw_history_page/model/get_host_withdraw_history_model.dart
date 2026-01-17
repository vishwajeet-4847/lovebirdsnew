// To parse this JSON data, do
//
//     final getHostWithdrawHistoryModel = getHostWithdrawHistoryModelFromJson(jsonString);

import 'dart:convert';

GetHostWithdrawHistoryModel getHostWithdrawHistoryModelFromJson(String str) => GetHostWithdrawHistoryModel.fromJson(json.decode(str));

String getHostWithdrawHistoryModelToJson(GetHostWithdrawHistoryModel data) => json.encode(data.toJson());

class GetHostWithdrawHistoryModel {
  bool? status;
  String? message;
  num? total;
  List<Datum>? data;

  GetHostWithdrawHistoryModel({
    this.status,
    this.message,
    this.total,
    this.data,
  });

  factory GetHostWithdrawHistoryModel.fromJson(Map<String, dynamic> json) => GetHostWithdrawHistoryModel(
        status: json["status"],
        message: json["message"],
        total: json["total"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total": total,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  num? person;
  String? agencyId;
  HostId? hostId;
  String? uniqueId;
  num? status;
  num? coin;
  num? amount;
  String? paymentGateway;
  PaymentDetails? paymentDetails;
  String? reason;
  String? requestDate;
  String? acceptOrDeclineDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.person,
    this.agencyId,
    this.hostId,
    this.uniqueId,
    this.status,
    this.coin,
    this.amount,
    this.paymentGateway,
    this.paymentDetails,
    this.reason,
    this.requestDate,
    this.acceptOrDeclineDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        person: json["person"],
        agencyId: json["agencyId"],
        hostId: json["hostId"] == null ? null : HostId.fromJson(json["hostId"]),
        uniqueId: json["uniqueId"],
        status: json["status"],
        coin: json["coin"],
        amount: json["amount"],
        paymentGateway: json["paymentGateway"],
        paymentDetails: json["paymentDetails"] == null ? null : PaymentDetails.fromJson(json["paymentDetails"]),
        reason: json["reason"],
        requestDate: json["requestDate"],
        acceptOrDeclineDate: json["acceptOrDeclineDate"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "person": person,
        "agencyId": agencyId,
        "hostId": hostId?.toJson(),
        "uniqueId": uniqueId,
        "status": status,
        "coin": coin,
        "amount": amount,
        "paymentGateway": paymentGateway,
        "paymentDetails": paymentDetails?.toJson(),
        "reason": reason,
        "requestDate": requestDate,
        "acceptOrDeclineDate": acceptOrDeclineDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class HostId {
  String? id;
  String? name;
  String? image;
  String? uniqueId;

  HostId({
    this.id,
    this.name,
    this.image,
    this.uniqueId,
  });

  factory HostId.fromJson(Map<String, dynamic> json) => HostId(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "uniqueId": uniqueId,
      };
}

class PaymentDetails {
  String? paymentDetail;
  String? bankAccountNumber;
  String? ifscCode;

  PaymentDetails({
    this.paymentDetail,
    this.bankAccountNumber,
    this.ifscCode,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        paymentDetail: json["Payment Detail"],
        bankAccountNumber: json["Bank Account Number"],
        ifscCode: json["IFSC code"],
      );

  Map<String, dynamic> toJson() => {
        "Payment Detail": paymentDetail,
        "Bank Account Number": bankAccountNumber,
        "IFSC code": ifscCode,
      };
}
