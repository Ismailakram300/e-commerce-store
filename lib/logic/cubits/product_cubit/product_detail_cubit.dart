import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository _productRepository;

  ProductDetailCubit(this._productRepository) : super(ProductDetailInitial());

  Future<void> loadProductDetails(int id) async {
    emit(ProductDetailLoading());
    try {
      final product = await _productRepository.getProductDetails(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}
