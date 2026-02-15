import '../../../../data/models/product.dart';

class CartItemDetail {
  final Product product;
  int quantity;

  CartItemDetail({required this.product, required this.quantity});
  
  double get totalPrice => product.price * quantity;
}
