import 'package:equatable/equatable.dart';
import '../../../../data/models/cart_item_detail.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemDetail> items;

  const CartLoaded({this.items = const []});

  double get total => items.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object> get props => [items];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
