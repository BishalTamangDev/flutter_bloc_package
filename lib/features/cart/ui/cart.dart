import 'package:bloc_first_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print("State: ${state.runtimeType}");
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;

              // empty cart
              if (successState.cartItems.isEmpty) {
                return const Center(
                  child: Text("Your cart is empty!"),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) => CartTileWidget(
                    productDataModal: successState.cartItems[index],
                    cartBloc: cartBloc,
                  ),
                );
              }
            default:
              return const Center(
                child: Text("Page Not Found!"),
              );
          }
          return Container();
        },
      ),
    );
  }
}
