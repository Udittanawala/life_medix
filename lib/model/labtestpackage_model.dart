// To parse this JSON data, do
//
//     final labtestPackageModel = labtestPackageModelFromJson(jsonString);

import 'dart:convert';

LabtestPackageModel labtestPackageModelFromJson(String str) =>
    LabtestPackageModel.fromJson(json.decode(str));

String labtestPackageModelToJson(LabtestPackageModel data) =>
    json.encode(data.toJson());

class LabtestPackageModel {
  bool status;
  String message;
  List<Datum> data;

  LabtestPackageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LabtestPackageModel.fromJson(Map<String, dynamic> json) =>
      LabtestPackageModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  int testId;
  String includes;
  String price;
  String time;

  Datum({
    required this.id,
    required this.name,
    required this.testId,
    required this.includes,
    required this.price,
    required this.time,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        testId: json["test_id"],
        includes: json["includes"],
        price: json["price"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "test_id": testId,
        "includes": includes,
        "price": price,
        "time": time,
      };
}
