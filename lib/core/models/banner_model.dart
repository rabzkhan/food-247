// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  bool? success;
  int? statusCode;
  List<BannerData>? response;

  BannerModel({
    this.success,
    this.statusCode,
    this.response,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        success: json["success"],
        statusCode: json["status_code"],
        response:
            json["response"] == null ? [] : List<BannerData>.from(json["response"]!.map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class BannerData {
  int? id;
  String? name;
  String? image;

  BannerData({
    this.id,
    this.name,
    this.image,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
