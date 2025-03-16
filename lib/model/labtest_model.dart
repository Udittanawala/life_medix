// To parse this JSON data, do
//
//     final labtestModel = labtestModelFromJson(jsonString);

import 'dart:convert';

LabtestModel labtestModelFromJson(String str) =>
    LabtestModel.fromJson(json.decode(str));

String labtestModelToJson(LabtestModel data) => json.encode(data.toJson());

class LabtestModel {
  bool status;
  String message;
  List<Datum> data;

  LabtestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LabtestModel.fromJson(Map<String, dynamic> json) => LabtestModel(
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
  String the0;
  String the1;
  String the2;
  String the3;
  String the4;
  String the5;
  String testId;
  String testDisease;
  String testPrice;
  String testDescr;
  String testDiscount;
  String testImg;

  Datum({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.testId,
    required this.testDisease,
    required this.testPrice,
    required this.testDescr,
    required this.testDiscount,
    required this.testImg,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        testId: json["test_id"],
        testDisease: json["test_disease"],
        testPrice: json["test_price"],
        testDescr: json["test_descr"],
        testDiscount: json["test_discount"],
        testImg: json["test_img"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "test_id": testId,
        "test_disease": testDisease,
        "test_price": testPrice,
        "test_descr": testDescr,
        "test_discount": testDiscount,
        "test_img": testImg,
      };
}
