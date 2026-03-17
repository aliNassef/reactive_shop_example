import 'package:eda_example/controller/cart_cubit/cart_state.dart';
import 'package:eda_example/views/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cart_cubit/cart_cubit.dart';
import '../controller/wishlist_cubit/wishlist_cubit.dart';
import '../controller/wishlist_cubit/wishlist_state.dart';
import 'cart_view.dart';
import 'wishlist_view.dart';

class ShopShell extends StatefulWidget {
  const ShopShell({super.key});
  @override
  State<ShopShell> createState() => _ShopShellState();
}

class _ShopShellState extends State<ShopShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [ProductListView(), WishlistView(), CartView()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (_, s) => Badge(
                isLabelVisible: s.count > 0,
                label: Text('${s.count}'),
                child: const Icon(Icons.favorite_border),
              ),
            ),
            selectedIcon: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (_, s) => Badge(
                isLabelVisible: s.count > 0,
                label: Text('${s.count}'),
                child: const Icon(Icons.favorite),
              ),
            ),
            label: 'Wishlist',
          ),
          NavigationDestination(
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (_, s) => Badge(
                isLabelVisible: s.count > 0,
                label: Text('${s.count}'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
            selectedIcon: BlocBuilder<CartCubit, CartState>(
              builder: (_, s) => Badge(
                isLabelVisible: s.count > 0,
                label: Text('${s.count}'),
                child: const Icon(Icons.shopping_bag),
              ),
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
