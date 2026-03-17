import 'package:eda_example/controller/wishlist_cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cart_cubit/cart_cubit.dart';
import '../controller/wishlist_cubit/wishlist_cubit.dart';
import '../widgets/wishlist_tile.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F4),
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: const Color(0xFFF9F7F4),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('🤍', style: TextStyle(fontSize: 56)),
                  SizedBox(height: 12),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Heart items on the Shop tab',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final product = state.items[i];
              // Read cart state directly — both cubits from same repo stream
              final isInCart = context.read<CartCubit>().state.contains(
                product.id,
              );
              return WishlistTile(
                product: product,
                isInCart: isInCart,
                onRemove: () => context.read<WishlistCubit>().remove(product),
                onMoveToCart: () =>
                    context.read<WishlistCubit>().moveToCart(product),
              );
            },
          );
        },
      ),
    );
  }
}
