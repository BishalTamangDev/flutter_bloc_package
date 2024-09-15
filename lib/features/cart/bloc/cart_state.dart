part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModal> cartItems;

  CartSuccessState({required this.cartItems});
}
