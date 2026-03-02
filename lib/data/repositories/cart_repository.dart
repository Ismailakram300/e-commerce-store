import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';
import '../models/cart.dart';

class CartRepository {
  
  
  final ApiClient _apiClient;
  
  CartRepository(this._apiClient);

  Future<List<Cart>> getUserCarts(int userId) async {
    try {
      final response = await _apiClient.get('${AppConstants.carts}/user/$userId');
      final List<dynamic> data = response.data;
      return data.map((json) => Cart.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }
  
  // Fake add to cart to simulate API call
  Future<void> addToCart(Cart cart) async {
     // await _apiClient.post(AppConstants.carts, data: ...);
  }
}
