import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/product.dart';
import '../../../../data/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductInitial());

  List<Product> _allProducts = [];
  List<String> _categories = [];
  String? _selectedCategory;

  Future<void> loadProducts({String? category}) async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getProducts(category: category);
      final categories = await _productRepository.getCategories();
      
      _allProducts = products;
      _categories = categories;
      _selectedCategory = category;
      
      emit(ProductLoaded(
        products: products,
        categories: categories,
        selectedCategory: category,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> filterByCategory(String? category) async {
    // If we already have all products loaded and just filtering, we can optimize
    final currentState = state;
    if (currentState is ProductLoaded && _allProducts.isNotEmpty) {
      // If filtering to "All", show all products
      if (category == null) {
        final filteredProducts = _allProducts;
        emit(ProductLoaded(
          products: filteredProducts,
          categories: _categories,
          selectedCategory: null,
          searchQuery: currentState.searchQuery,
        ));
        return;
      }
      
      // Filter locally if we have all products
      // But we need to check if we have products from all categories
      // For now, if we're switching categories, we need to fetch
      // This is a trade-off: we could cache all products on initial load
      await loadProducts(category: category);
    } else {
      // If we don't have products yet, load them
      await loadProducts(category: category);
    }
  }

  void searchProducts(String query) {
    if (_allProducts.isEmpty) return;

    final filteredProducts = query.isEmpty
        ? _allProducts
        : _allProducts.where((product) {
            final title = product.title.toLowerCase();
            final description = product.description.toLowerCase();
            final searchLower = query.toLowerCase();
            return title.contains(searchLower) || description.contains(searchLower);
          }).toList();

    emit(ProductLoaded(
      products: filteredProducts,
      categories: _categories,
      selectedCategory: _selectedCategory,
      searchQuery: query,
    ));
  }
}
