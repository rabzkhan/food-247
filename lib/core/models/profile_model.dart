/// success : true
/// status_code : 200
/// data : {"customer_id":"19","full_name":" ","email":"hasibakon75@gmail.com","photo":null,"phone":"1727123374","country_code":"+880","address":" ","device_token":null,"created_at":"2024-04-04T17:54:52.000000Z","updated_at":"2024-04-04T17:54:52.000000Z"}

class ProfileModel {
  ProfileModel({
      this.success, 
      this.statusCode, 
      this.data,});

  ProfileModel.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  num? statusCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status_code'] = statusCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// customer_id : "19"
/// full_name : " "
/// email : "hasibakon75@gmail.com"
/// photo : null
/// phone : "1727123374"
/// country_code : "+880"
/// address : " "
/// device_token : null
/// created_at : "2024-04-04T17:54:52.000000Z"
/// updated_at : "2024-04-04T17:54:52.000000Z"

class Data {
  Data({
      this.customerId, 
      this.fullName, 
      this.email, 
      this.photo, 
      this.phone, 
      this.countryCode, 
      this.address, 
      this.deviceToken, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    email = json['email'];
    photo = json['photo'];
    phone = json['phone'];
    countryCode = json['country_code'];
    address = json['address'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? customerId;
  String? fullName;
  String? email;
  dynamic photo;
  String? phone;
  String? countryCode;
  String? address;
  dynamic deviceToken;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['full_name'] = fullName;
    map['email'] = email;
    map['photo'] = photo;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['address'] = address;
    map['device_token'] = deviceToken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}