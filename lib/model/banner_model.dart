// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  bool status;
  String message;
  List<Datum> data;

  BannerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
  String bId;
  String bName;
  String bImg;
  String bActive;

  Datum({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.the3,
    required this.bId,
    required this.bName,
    required this.bImg,
    required this.bActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        the3: json["3"],
        bId: json["b_id"],
        bName: json["b_name"],
        bImg: json["b_img"],
        bActive: json["b_active"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "3": the3,
        "b_id": bId,
        "b_name": bName,
        "b_img": bImg,
        "b_active": bActive,
      };
}
