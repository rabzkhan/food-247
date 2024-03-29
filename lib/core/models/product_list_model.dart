// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  bool? success;
  ProductListData? data;
  int? statusCode;

  ProductListModel({
    this.success,
    this.data,
    this.statusCode,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        success: json["success"],
        data: json["data"] == null ? null : ProductListData.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "status_code": statusCode,
      };
}

class ProductListData {
  String? productTypeId;
  String? productTypeName;
  String? image;
  List<Products>? productNames;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  bool? morePage;

  ProductListData({
    this.productTypeId,
    this.productTypeName,
    this.image,
    this.productNames,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.morePage,
  });

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
        productTypeId: json["product_type_id"],
        productTypeName: json["product_type_name"],
        image: json["image"],
        productNames: json["product_names"] == null
            ? []
            : List<Products>.from(json["product_names"]!.map((x) => Products.fromJson(x))),
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
        morePage: json["morePage"],
      );

  Map<String, dynamic> toJson() => {
        "product_type_id": productTypeId,
        "product_type_name": productTypeName,
        "image": image,
        "product_names": productNames == null ? [] : List<dynamic>.from(productNames!.map((x) => x.toJson())),
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
        "morePage": morePage,
      };
}

class Products {
  String? productNameId;
  dynamic sizeId;
  dynamic colorId;
  String? productName;
  String? code;
  String? description;
  String? price;
  String? quantity;
  String? imagePath;
  String? productTypeId;
  dynamic offerAmount;
  String? isActive;
  String? summerOfferStatus;
  String? winterOfferStatus;

  Products({
    this.productNameId,
    this.sizeId,
    this.colorId,
    this.productName,
    this.code,
    this.description,
    this.price,
    this.quantity,
    this.imagePath,
    this.productTypeId,
    this.offerAmount,
    this.isActive,
    this.summerOfferStatus,
    this.winterOfferStatus,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productNameId: json["product_name_id"],
        sizeId: json["size_id"],
        colorId: json["color_id"],
        productName: json["product_name"],
        code: json["code"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        imagePath: json["imagePath"],
        productTypeId: json["product_type_id"],
        offerAmount: json["offer_amount"],
        isActive: json["is_active"],
        summerOfferStatus: json["summer_offer_status"],
        winterOfferStatus: json["winter_offer_status"],
      );

  Map<String, dynamic> toJson() => {
        "product_name_id": productNameId,
        "size_id": sizeId,
        "color_id": colorId,
        "product_name": productName,
        "code": code,
        "description": description,
        "price": price,
        "quantity": quantity,
        "imagePath": imagePath,
        "product_type_id": productTypeId,
        "offer_amount": offerAmount,
        "is_active": isActive,
        "summer_offer_status": summerOfferStatus,
        "winter_offer_status": winterOfferStatus,
      };
}
