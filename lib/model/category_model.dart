// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool status;
  String message;
  List<Datum> data;

  CategoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  String catId;
  String catName;
  String catImg;

  Datum({
    required this.the0,
    required this.the1,
    required this.the2,
    required this.catId,
    required this.catName,
    required this.catImg,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        the0: json["0"],
        the1: json["1"],
        the2: json["2"],
        catId: json["cat_id"],
        catName: json["cat_name"],
        catImg: json["cat_img"],
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "1": the1,
        "2": the2,
        "cat_id": catId,
        "cat_name": catName,
        "cat_img": catImg,
      };
}
