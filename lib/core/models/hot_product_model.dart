import 'package:food/core/models/product_list_model.dart';

class HotProductsModel {
  bool? success;
  int? statusCode;
  List<Products>? data;
  String? message;

  HotProductsModel({
    this.success,
    this.statusCode,
    this.data,
    this.message,
  });

  factory HotProductsModel.fromJson(Map<String, dynamic> json) => HotProductsModel(
        success: json["success"],
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Products>.from(json["data"]!.map((x) => Products.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}
