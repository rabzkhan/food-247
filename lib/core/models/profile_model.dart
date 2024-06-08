// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? success;
  int? statusCode;
  int? userId;
  ProfileData? data;

  ProfileModel({
    this.success,
    this.statusCode,
    this.userId,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        statusCode: json["status_code"],
        userId: json["user_id"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "user_id": userId,
        "data": data?.toJson(),
      };
}

class ProfileData {
  String? customerId;
  String? fullName;
  String? email;
  dynamic photo;
  String? phone;
  String? countryCode;
  String? address;
  dynamic deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileData({
    this.customerId,
    this.fullName,
    this.email,
    this.photo,
    this.phone,
    this.countryCode,
    this.address,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        customerId: json["customer_id"],
        fullName: json["full_name"],
        email: json["email"],
        photo: json["photo"],
        phone: json["phone"],
        countryCode: json["country_code"],
        address: json["address"],
        deviceToken: json["device_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "full_name": fullName,
        "email": email,
        "photo": photo,
        "phone": phone,
        "country_code": countryCode,
        "address": address,
        "device_token": deviceToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
