import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eda_example/repo/cart_repo.dart';
import 'package:eda_example/repo/wishlist_repo.dart';

import '../../models/product.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepo _wishlistRepo;
  final CartRepo _cartRepo;
  late final StreamSubscription _sub;

  WishlistCubit(this._wishlistRepo, this._cartRepo)
    : super(const WishlistState()) {
    _sub = _wishlistRepo.wishlistStream.listen((items) {
      emit(WishlistState(items: items));
    });
  }

  void remove(Product p) => _wishlistRepo.removeFromWishlist(p);
  void moveToCart(Product p) {
    _wishlistRepo.removeFromWishlist(p);
    if (!_cartRepo.isInCart(p.id)) _cartRepo.toggleCart(p);
  }

  @override
  Future<void> close() async {
    _wishlistRepo.dispose();
    await _sub.cancel();
    return super.close();
  }
}
