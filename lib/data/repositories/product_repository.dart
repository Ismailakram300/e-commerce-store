import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';
import '../models/product.dart';

class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository(this._apiClient);

  Future<List<Product>> getProducts({String? category}) async {
    try {
      final String path = category != null 
          ? '${AppConstants.products}/category/$category'
          : AppConstants.products;
          
      final response = await _apiClient.get(path);
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _apiClient.get(AppConstants.categories);
      final List<dynamic> data = response.data;
      return data.map((e) => e.toString()).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<Product> getProductDetails(int id) async {
    try {
      final response = await _apiClient.get('${AppConstants.products}/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
