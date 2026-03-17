import 'package:eda_example/controller/product_cubit/product_cubit.dart';
import 'package:eda_example/controller/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_card.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: const Color(0xFFF9F7F4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, i) {
              final product = state.products[i];
              return ProductCard(
                product: product,
                isWishlisted: state.isWishlisted(product.id),
                isCarted: state.isCarted(product.id),
                onWishlist: () =>
                    context.read<ProductCubit>().toggleWishlist(product),
                onCart: () => context.read<ProductCubit>().toggleCart(product),
              );
            },
          );
        },
      ),
    );
  }
}
