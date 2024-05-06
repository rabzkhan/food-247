// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  bool? success;
  List<ProductDetails>? data;
  int? statusCode;

  ProductDetailsModel({
    this.success,
    this.data,
    this.statusCode,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        success: json["success"],
        data:
            json["data"] == null ? [] : List<ProductDetails>.from(json["data"]!.map((x) => ProductDetails.fromJson(x))),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status_code": statusCode,
      };
}

class ProductDetails {
  String? productNameId;
  List<ProductExtraItem>? productExtraItem;
  List<ProductSize>? productSize;

  ProductDetails({
    this.productNameId,
    this.productExtraItem,
    this.productSize,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productNameId: json["product_name_id"],
        productExtraItem: json["product_extra_item"] == null
            ? []
            : List<ProductExtraItem>.from(json["product_extra_item"]!.map((x) => ProductExtraItem.fromJson(x))),
        productSize: json["product_size"] == null
            ? []
            : List<ProductSize>.from(json["product_size"]!.map((x) => ProductSize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_name_id": productNameId,
        "product_extra_item":
            productExtraItem == null ? [] : List<dynamic>.from(productExtraItem!.map((x) => x.toJson())),
        "product_size": productSize == null ? [] : List<dynamic>.from(productSize!.map((x) => x.toJson())),
      };
}

class ProductExtraItem {
  int? id;
  String? name;
  String? price;
  String? image;

  ProductExtraItem({
    this.id,
    this.name,
    this.price,
    this.image,
  });

  factory ProductExtraItem.fromJson(Map<String, dynamic> json) => ProductExtraItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
      };
}

class ProductSize {
  int? id;
  String? name;
  String? sizePrice;

  ProductSize({
    this.id,
    this.name,
    this.sizePrice,
  });

  factory ProductSize.fromJson(Map<String, dynamic> json) => ProductSize(
        id: json["id"],
        name: json["name"],
        sizePrice: json["size_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "size_price": sizePrice,
      };
}
