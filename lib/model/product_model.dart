// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  bool status;
  String message;
  List<Product> data;

  ProductModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Product {
  String subId;
  String subName;
  String subImg;
  String subImg1;
  String subImg2;
  SubImg3 subImg3;
  String subOffer;
  String subDeliveryby;
  SubVeriant subVeriant;
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
  String wishlist;

  Product({
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
    required this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        subId: json["sub_id"],
        subName: json["sub_name"],
        subImg: json["sub_img"],
        subImg1: json["sub_img1"],
        subImg2: json["sub_img2"],
        subImg3: subImg3Values.map[json["sub_img3"]]!,
        subOffer: json["sub_offer"],
        subDeliveryby: json["sub_deliveryby"],
        subVeriant: subVeriantValues.map[json["sub_veriant"]]!,
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
        wishlist: json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "sub_id": subId,
        "sub_name": subName,
        "sub_img": subImg,
        "sub_img1": subImg1,
        "sub_img2": subImg2,
        "sub_img3": subImg3Values.reverse[subImg3],
        "sub_offer": subOffer,
        "sub_deliveryby": subDeliveryby,
        "sub_veriant": subVeriantValues.reverse[subVeriant],
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
        "wishlist": wishlist,
      };
}

enum SubImg3 { EMPTY, IMAGES }

final subImg3Values =
    EnumValues({"": SubImg3.EMPTY, "./images/": SubImg3.IMAGES});

enum SubVeriant { DONE, EMPTY, OK, OKAY }

final subVeriantValues = EnumValues({
  "done": SubVeriant.DONE,
  "-": SubVeriant.EMPTY,
  "ok": SubVeriant.OK,
  "okay": SubVeriant.OKAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
