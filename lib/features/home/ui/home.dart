import 'package:bloc_first_app/features/cart/ui/cart.dart';
import 'package:bloc_first_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_first_app/features/home/ui/product_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          // navigate to cart page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cart(),
            ),
          );
        } else if (state is HomeProductCartedActionState) {
          //   show product added to cart message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
              content: Text(
                "Product added to cart",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Grocery App'),
                backgroundColor: Colors.teal,
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) => ProductTileWidget(
                    productDataModal: successState.products[index],
                    homeBloc: homeBloc,
                  ),
                ),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text("Error occurred!"),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hourglass_empty),
                    SizedBox(height: 10.0),
                    Text("Page Not Found!"),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
