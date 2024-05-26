class CartModel {
  final int? productId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final int? quantity;
  final double? price;
  final PSize? size;
  final List<ExtraItem>? extraItems;

  CartModel({
    this.productId,
    this.title,
    this.description,
    this.imageUrl,
    this.quantity,
    this.price,
    this.size,
    this.extraItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> map) {
    // Parse size
    Map<String, dynamic>? sizeData = map['size'];
    PSize? size;
    if (sizeData != null) {
      size = PSize.fromJson(sizeData);
    }

    // Parse extra items
    List<dynamic>? extrasData = map['extraItems'];
    List<ExtraItem>? extras;
    if (extrasData != null) {
      extras = extrasData.map((item) => ExtraItem.fromJson(item)).toList();
    }

    return CartModel(
      productId: map['productId'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      price: map['price'],
      size: size,
      extraItems: extras,
    );
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>>? extrasData;
    if (extraItems != null) {
      extrasData = extraItems!.map((item) => item.toMap()).toList();
    }

    return {
      'productId': productId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'size': size?.toMap(),
      'extraItems': extrasData,
    };
  }

  // Adding toJson method
  Map<String, dynamic> toJson() {
    return toMap();
  }
}

class PSize {
  final int? id;
  final String? name;
  final double? price;

  PSize({
    this.id,
    this.name,
    this.price,
  });

  factory PSize.fromJson(Map<String, dynamic> map) {
    return PSize(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Adding toJson method
  Map<String, dynamic> toJson() {
    return toMap();
  }
}

class ExtraItem {
  final int? id;
  final String? name;
  final double? price;

  ExtraItem({
    this.id,
    this.name,
    this.price,
  });

  factory ExtraItem.fromJson(Map<String, dynamic> map) {
    return ExtraItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  // Adding toJson method
  Map<String, dynamic> toJson() {
    return toMap();
  }
}
