class CartModel {
  final int? productId;
  final String? title;
  final String? description;
  final String? imageUrl;
  final int? quantity;
  final double? price;
  CartModel({this.productId, this.title, this.description, this.imageUrl, this.quantity, this.price});

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }
}
