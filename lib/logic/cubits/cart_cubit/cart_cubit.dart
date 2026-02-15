import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/cart_item_detail.dart';
import '../../../../data/models/product.dart';
import '../../../../data/repositories/cart_repository.dart';
import '../../../../data/repositories/product_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final ProductRepository _productRepository;

  CartCubit(this._cartRepository, this._productRepository) : super(CartInitial());

  List<CartItemDetail> _items = [];

  Future<void> loadCart(int userId) async {
    emit(CartLoading());
    try {
      final carts = await _cartRepository.getUserCarts(userId);
      
      if (carts.isEmpty) {
        _items = [];
        emit(const CartLoaded(items: []));
        return;
      }

      // FakeStore API returns multiple carts, we'll just take the first one for this demo
      // or merge them. Let's take the first one.
      final cart = carts.first;
      
      _items = [];
      for (var item in cart.products) {
        final product = await _productRepository.getProductDetails(item.productId);
        _items.add(CartItemDetail(product: product, quantity: item.quantity));
      }
      
      emit(CartLoaded(items: List.from(_items)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void addToCart(Product product) {
    // Check if exists
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      // Create a new CartItemDetail object instead of mutating the existing one
      _items[index] = CartItemDetail(
        product: _items[index].product,
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItemDetail(product: product, quantity: 1));
    }
    emit(CartLoaded(items: List.from(_items)));
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    emit(CartLoaded(items: List.from(_items)));
  }
  
  void updateQuantity(int productId, int change) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final newQuantity = _items[index].quantity + change;
      if (newQuantity > 0) {
        // Create a new CartItemDetail object instead of mutating the existing one
        _items[index] = CartItemDetail(
          product: _items[index].product,
          quantity: newQuantity,
        );
      } else {
        _items.removeAt(index);
      }
      emit(CartLoaded(items: List.from(_items)));
    }
  }
}
