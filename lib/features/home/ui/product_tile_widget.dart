import 'package:bloc_first_app/features/home/bloc/home_bloc.dart';
import 'package:bloc_first_app/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget(
      {super.key, required this.productDataModal, required this.homeBloc});

  final HomeBloc homeBloc;

  final ProductDataModal productDataModal;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(productDataModal.imageUrl),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        productDataModal.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: IconButton(
                        onPressed: () {
                          //   add to cart
                          homeBloc.add(HomeProductCartButtonClickedEvent(
                              clickedProduct: productDataModal));
                        },
                        icon: const Icon(Icons.shopping_bag_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
                Text(
                  productDataModal.description,
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "\$ ${productDataModal.price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
