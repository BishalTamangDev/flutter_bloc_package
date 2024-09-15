import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_first_app/data/cart_items.dart';
import 'package:bloc_first_app/data/grocery_data.dart';
import 'package:bloc_first_app/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map(
              (e) => ProductDataModal(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl'],
              ),
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print("Cart product clicked!");
    cartItems.add(event.clickedProduct);
    emit(HomeProductCartedActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart navigate clicked!");
    emit(HomeNavigateToCartPageActionState());
  }
}
