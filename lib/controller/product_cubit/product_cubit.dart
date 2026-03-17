import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eda_example/repo/product_repo.dart';
import 'package:eda_example/repo/wishlist_repo.dart';
import '../../models/product.dart';
import '../../repo/cart_repo.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({
    required WishlistRepo wishlistRepo,
    required CartRepo cartRepo,
    required ProductRepo productsRepo,
  }) : _productsRepo = productsRepo,
       _wishlistRepo = wishlistRepo,
       _cartRepo = cartRepo,
       super(ProductState());

  final WishlistRepo _wishlistRepo;
  final CartRepo _cartRepo;
  final ProductRepo _productsRepo;

  StreamSubscription? _wishlistSubscription;
  StreamSubscription? _cartSubscription;

  void getProducts() async {
    emit(state.copyWith(status: Status.loading));

    final products = await _productsRepo.getProducts();
    emit(state.copyWith(status: Status.success, products: products));
    _wishlistSubscription = _wishlistRepo.wishlistStream.listen((wishlist) {
      final wishlistedIds = wishlist.map((p) => p.id).toSet();
      emit(state.copyWith(wishlistedIds: wishlistedIds));
    });
    _cartSubscription = _cartRepo.cartItemsStream.listen((cart) {
      final cartedIds = cart.map((c) => c.product.id).toSet();
      emit(state.copyWith(cartedIds: cartedIds));
    });
  }

  void toggleWishlist(Product p) => _wishlistRepo.toggleWishlist(p);
  void toggleCart(Product p) => _cartRepo.toggleCart(p);

  @override
  Future<void> close() async {
    await _wishlistSubscription?.cancel();
    await _cartSubscription?.cancel();
    return super.close();
  }
}
