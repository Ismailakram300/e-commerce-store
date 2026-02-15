import 'package:equatable/equatable.dart';
import '../../../../data/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String? searchQuery;

  const ProductLoaded({
    required this.products,
    required this.categories,
    this.selectedCategory,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, categories, selectedCategory, searchQuery];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
