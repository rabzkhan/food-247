class AddressListModel {
  bool? success;
  int? statusCode;
  List<Address>? data;

  AddressListModel({
    this.success,
    this.statusCode,
    this.data,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) => AddressListModel(
        success: json["success"],
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Address>.from(json["data"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  String? userId;
  String? address;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.userId,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
