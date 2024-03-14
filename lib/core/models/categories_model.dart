// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  bool? success;
  List<Category>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  bool? morePage;
  int? statusCode;

  CategoriesModel({
    this.success,
    this.data,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.morePage,
    this.statusCode,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<Category>.from(json["data"]!.map((x) => Category.fromJson(x))),
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
        morePage: json["morePage"],
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "morePage": morePage,
        "status_code": statusCode,
      };
}

class Category {
  String? productTypeId;
  String? productTypeName;
  String? image;

  Category({
    this.productTypeId,
    this.productTypeName,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        productTypeId: json["product_type_id"],
        productTypeName: json["product_type_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "product_type_id": productTypeId,
        "product_type_name": productTypeName,
        "image": image,
      };
}
