// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  bool? success;
  int? statusCode;
  String? message;
  CustomerInfo? customerInfo;
  List<Order>? orders;

  OrderListModel({
    this.success,
    this.statusCode,
    this.message,
    this.customerInfo,
    this.orders,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        success: json["success"],
        statusCode: json["status_code"],
        message: json["message"],
        customerInfo: json["customer_info"] == null ? null : CustomerInfo.fromJson(json["customer_info"]),
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "message": message,
        "customer_info": customerInfo?.toJson(),
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class CustomerInfo {
  String? customerId;
  String? customerEmail;
  String? customerNumber;

  CustomerInfo({
    this.customerId,
    this.customerEmail,
    this.customerNumber,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        customerId: json["customer_id"],
        customerEmail: json["customer_email"],
        customerNumber: json["customer_number"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_email": customerEmail,
        "customer_number": customerNumber,
      };
}

class Order {
  String? id;
  String? serviceProviderId;
  dynamic deliveryMenId;
  dynamic deliveryMenStatus;
  dynamic deliveryMenExpireTime;
  String? serviceTableId;
  String? orderType;
  String? orderCode;
  dynamic pickupOption;
  dynamic offerId;
  String? orderStatus;
  dynamic paymentReference;
  String? totalAmount;
  dynamic discount;
  String? paidAmount;
  dynamic paymentMethod;
  dynamic paymentMeta;
  dynamic paymentStatus;
  String? customerAddress;
  String? latValue;
  String? longValue;
  List<OrderDetail>? orderDetails;

  Order({
    this.id,
    this.serviceProviderId,
    this.deliveryMenId,
    this.deliveryMenStatus,
    this.deliveryMenExpireTime,
    this.serviceTableId,
    this.orderType,
    this.orderCode,
    this.pickupOption,
    this.offerId,
    this.orderStatus,
    this.paymentReference,
    this.totalAmount,
    this.discount,
    this.paidAmount,
    this.paymentMethod,
    this.paymentMeta,
    this.paymentStatus,
    this.customerAddress,
    this.latValue,
    this.longValue,
    this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        serviceProviderId: json["service_provider_id"],
        deliveryMenId: json["delivery_men_id"],
        deliveryMenStatus: json["delivery_men_status"],
        deliveryMenExpireTime: json["delivery_men_expire_time"],
        serviceTableId: json["service_table_id"],
        orderType: json["order_type"],
        orderCode: json["order_code"],
        pickupOption: json["pickup_option"],
        offerId: json["offer_id"],
        orderStatus: json["order_status"],
        paymentReference: json["payment_reference"],
        totalAmount: json["total_amount"],
        discount: json["discount"],
        paidAmount: json["paid_amount"],
        paymentMethod: json["payment_method"],
        paymentMeta: json["payment_meta"],
        paymentStatus: json["payment_status"],
        customerAddress: json["customer_address"],
        latValue: json["lat_value"],
        longValue: json["long_value"],
        orderDetails: json["order_details"] == null
            ? []
            : List<OrderDetail>.from(json["order_details"]!.map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_provider_id": serviceProviderId,
        "delivery_men_id": deliveryMenId,
        "delivery_men_status": deliveryMenStatus,
        "delivery_men_expire_time": deliveryMenExpireTime,
        "service_table_id": serviceTableId,
        "order_type": orderType,
        "order_code": orderCode,
        "pickup_option": pickupOption,
        "offer_id": offerId,
        "order_status": orderStatus,
        "payment_reference": paymentReference,
        "total_amount": totalAmount,
        "discount": discount,
        "paid_amount": paidAmount,
        "payment_method": paymentMethod,
        "payment_meta": paymentMeta,
        "payment_status": paymentStatus,
        "customer_address": customerAddress,
        "lat_value": latValue,
        "long_value": longValue,
        "order_details": orderDetails == null ? [] : List<dynamic>.from(orderDetails!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  String? productId;
  String? title;
  String? description;
  String? imageUrl;
  String? quantity;
  String? price;
  String? sizeId;
  String? sizeName;
  String? sizePrice;
  List<ExtraItem>? extraItems;

  OrderDetail({
    this.productId,
    this.title,
    this.description,
    this.imageUrl,
    this.quantity,
    this.price,
    this.sizeId,
    this.sizeName,
    this.sizePrice,
    this.extraItems,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["productId"],
        title: json["title"]!,
        description: json["description"]!,
        imageUrl: json["imageUrl"]!,
        quantity: json["quantity"],
        price: json["price"],
        sizeId: json["size_id"],
        sizeName: json["size_name"]!,
        sizePrice: json["size_price"],
        extraItems: json["extraItems"] == null
            ? []
            : List<ExtraItem>.from(json["extraItems"]!.map((x) => ExtraItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "quantity": quantity,
        "price": price,
        "size_id": sizeId,
        "size_name": sizeName,
        "size_price": sizePrice,
        "extraItems": extraItems == null ? [] : List<dynamic>.from(extraItems!.map((x) => x.toJson())),
      };
}

class ExtraItem {
  String? id;
  String? extraItemId;
  String? orderDetailsId;
  String? orderId;
  String? productNameId;
  String? extraItemName;
  String? extraItemPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

  ExtraItem({
    this.id,
    this.extraItemId,
    this.orderDetailsId,
    this.orderId,
    this.productNameId,
    this.extraItemName,
    this.extraItemPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory ExtraItem.fromJson(Map<String, dynamic> json) => ExtraItem(
        id: json["id"],
        extraItemId: json["extra_item_id"],
        orderDetailsId: json["order_details_id"],
        orderId: json["order_id"],
        productNameId: json["product_name_id"],
        extraItemName: json["extra_item_name"]!,
        extraItemPrice: json["extra_item_price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "extra_item_id": extraItemId,
        "order_details_id": orderDetailsId,
        "order_id": orderId,
        "product_name_id": productNameId,
        "extra_item_name": extraItemName,
        "extra_item_price": extraItemPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
