// To parse this JSON data, do
//
//     final relatedProductModel = relatedProductModelFromJson(jsonString);

import 'dart:convert';

RelatedProductModel relatedProductModelFromJson(String str) =>
    RelatedProductModel.fromJson(json.decode(str));

String relatedProductModelToJson(RelatedProductModel data) =>
    json.encode(data.toJson());

class RelatedProductModel {
  bool status;
  String message;
  List<Datum> data;

  RelatedProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RelatedProductModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductModel(
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
  String subId;
  String subName;
  String subImg;
  String subImg1;
  String subImg2;
  String subImg3;
  String subOffer;
  String subDeliveryby;
  String subVeriant;
  String subPacksize;
  String subDiscription;
  String subBenifies;
  String subPrice;
  String subIngredients;
  String subUses;
  String subSaftyInfo;
  String subExpiresDate;
  String subBrend;
  String catId;

  Datum({
    required this.subId,
    required this.subName,
    required this.subImg,
    required this.subImg1,
    required this.subImg2,
    required this.subImg3,
    required this.subOffer,
    required this.subDeliveryby,
    required this.subVeriant,
    required this.subPacksize,
    required this.subDiscription,
    required this.subBenifies,
    required this.subPrice,
    required this.subIngredients,
    required this.subUses,
    required this.subSaftyInfo,
    required this.subExpiresDate,
    required this.subBrend,
    required this.catId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subId: json["sub_id"],
        subName: json["sub_name"],
        subImg: json["sub_img"],
        subImg1: json["sub_img1"],
        subImg2: json["sub_img2"],
        subImg3: json["sub_img3"],
        subOffer: json["sub_offer"],
        subDeliveryby: json["sub_deliveryby"],
        subVeriant: json["sub_veriant"],
        subPacksize: json["sub_packsize"],
        subDiscription: json["sub_discription"],
        subBenifies: json["sub_benifies"],
        subPrice: json["sub_price"],
        subIngredients: json["sub_ingredients"],
        subUses: json["sub_uses"],
        subSaftyInfo: json["sub_safty_info"],
        subExpiresDate: json["sub_expires_date"],
        subBrend: json["sub_brend"],
        catId: json["cat_id"],
      );

  Map<String, dynamic> toJson() => {
        "sub_id": subId,
        "sub_name": subName,
        "sub_img": subImg,
        "sub_img1": subImg1,
        "sub_img2": subImg2,
        "sub_img3": subImg3,
        "sub_offer": subOffer,
        "sub_deliveryby": subDeliveryby,
        "sub_veriant": subVeriant,
        "sub_packsize": subPacksize,
        "sub_discription": subDiscription,
        "sub_benifies": subBenifies,
        "sub_price": subPrice,
        "sub_ingredients": subIngredients,
        "sub_uses": subUses,
        "sub_safty_info": subSaftyInfo,
        "sub_expires_date": subExpiresDate,
        "sub_brend": subBrend,
        "cat_id": catId,
      };
}
