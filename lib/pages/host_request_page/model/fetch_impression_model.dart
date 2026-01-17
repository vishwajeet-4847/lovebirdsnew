import 'dart:convert';

FetchImpressionModel fetchImpressionModelFromJson(String str) =>
    FetchImpressionModel.fromJson(json.decode(str));

String fetchImpressionModelToJson(FetchImpressionModel data) =>
    json.encode(data.toJson());

class FetchImpressionModel {
  bool status;
  String message;
  List<PersonalityImpression> personalityImpressions;

  FetchImpressionModel({
    required this.status,
    required this.message,
    required this.personalityImpressions,
  });

  factory FetchImpressionModel.fromJson(Map<String, dynamic> json) =>
      FetchImpressionModel(
        status: json["status"],
        message: json["message"],
        personalityImpressions: List<PersonalityImpression>.from(
            json["personalityImpressions"]
                .map((x) => PersonalityImpression.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "personalityImpressions":
            List<dynamic>.from(personalityImpressions.map((e) => e.toJson())),
      };
}

class PersonalityImpression {
  String id;
  String name;

  PersonalityImpression({
    required this.id,
    required this.name,
  });

  factory PersonalityImpression.fromJson(Map<String, dynamic> json) =>
      PersonalityImpression(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
