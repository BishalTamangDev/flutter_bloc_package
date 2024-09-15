part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModal clickedProduct;

  HomeProductWishlistButtonClickedEvent({required this.clickedProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModal clickedProduct;

  HomeProductCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
