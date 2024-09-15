part of 'home_bloc.dart';

sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModal> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductCartedActionState extends HomeActionState {}
