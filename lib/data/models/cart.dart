class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartItem> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
    );
  }
}

class CartItem {
  final int productId;
  final int quantity;

  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
  
  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
