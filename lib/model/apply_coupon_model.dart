// To parse this JSON data, do
//
//     final applyCouponModel = applyCouponModelFromJson(jsonString);

import 'dart:convert';

ApplyCouponModel applyCouponModelFromJson(String str) =>
    ApplyCouponModel.fromJson(json.decode(str));

String applyCouponModelToJson(ApplyCouponModel data) =>
    json.encode(data.toJson());

class ApplyCouponModel {
  bool status;
  String message;
  List<Coupon> data;

  ApplyCouponModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApplyCouponModel.fromJson(Map<String, dynamic> json) =>
      ApplyCouponModel(
        status: json["status"],
        message: json["message"],
        data: List<Coupon>.from(json["data"].map((x) => Coupon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Coupon {
  String couId;
  String couTitle;
  String couCode;
  String couDesPrice;
  String couImg;
  String couValue;
  String couActive;

  Coupon({
    required this.couId,
    required this.couTitle,
    required this.couCode,
    required this.couDesPrice,
    required this.couImg,
    required this.couValue,
    required this.couActive,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        couId: json["cou_id"],
        couTitle: json["cou_title"],
        couCode: json["cou_code"],
        couDesPrice: json["cou_des_price"],
        couImg: json["cou_img"],
        couValue: json["cou_value"],
        couActive: json["cou_active"],
      );

  Map<String, dynamic> toJson() => {
        "cou_id": couId,
        "cou_title": couTitle,
        "cou_code": couCode,
        "cou_des_price": couDesPrice,
        "cou_img": couImg,
        "cou_value": couValue,
        "cou_active": couActive,
      };
}
