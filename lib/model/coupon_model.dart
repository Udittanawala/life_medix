// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  bool status;
  String message;
  List<Datum> data;

  CouponModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
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
  String the6;
  String couId;
  String couTitle;
  String couCode;
  String couDesPrice;
  String couImg;
  String couValue;
  String couActive;

  Datum({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.the4,
    required this.the5,
    required this.the6,
    required this.couId,
    required this.couTitle,
    required this.couCode,
    required this.couDesPrice,
    required this.couImg,
    required this.couValue,
    required this.couActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        the4: json["4"],
        the5: json["5"],
        the6: json["6"],
        couId: json["cou_id"],
        couTitle: json["cou_title"],
        couCode: json["cou_code"],
        couDesPrice: json["cou_des_price"],
        couImg: json["cou_img"],
        couValue: json["cou_value"],
        couActive: json["cou_active"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "4": the4,
        "5": the5,
        "6": the6,
        "cou_id": couId,
        "cou_title": couTitle,
        "cou_code": couCode,
        "cou_des_price": couDesPrice,
        "cou_img": couImg,
        "cou_value": couValue,
        "cou_active": couActive,
      };
}
