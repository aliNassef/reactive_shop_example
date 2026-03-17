import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eda_example/repo/cart_repo.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _repo;
  late final StreamSubscription _sub;

  CartCubit(this._repo) : super(const CartState()) {
    _sub = _repo.cartItemsStream.listen((items) {
      emit(CartState(items: items));
    });
  }

  void increment(String id) => _repo.incrementCart(id);
  void decrement(String id) => _repo.decrementCart(id);
  void remove(String id) => _repo.removeFromCart(id);

  @override
  Future<void> close() async {
    _repo.dispose();
    await _sub.cancel();
    return super.close();
  }
}
