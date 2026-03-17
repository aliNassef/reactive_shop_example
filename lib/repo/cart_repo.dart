import 'package:rxdart/rxdart.dart';

import '../models/cart_item.dart';
import '../models/product.dart';

abstract class CartRepo {
  Stream<List<CartItem>> get cartItemsStream;

  void toggleCart(Product product);
  void removeFromCart(String productId);
  void incrementCart(String productId);
  void decrementCart(String productId);
  bool isInCart(String id);
  void dispose();
}

class CartRepoImpl extends CartRepo {
  final _cartController = BehaviorSubject<List<CartItem>>.seeded([]);
  @override
  Stream<List<CartItem>> get cartItemsStream => _cartController.stream;
  @override
  void toggleCart(Product product) {
    final current = List<CartItem>.from(_cartController.value);
    final idx = current.indexWhere((i) => i.product.id == product.id);
    idx >= 0 ? current.removeAt(idx) : current.add(CartItem(product: product));
    _cartController.add(current);
  }

  @override
  void incrementCart(String productId) {
    final current = _cartController.value.map((i) {
      if (i.product.id == productId) {
        return i.copyWith(quantity: i.quantity + 1);
      }
      return i;
    }).toList();
    _cartController.add(current);
  }

  @override
  void decrementCart(String productId) {
    final current = _cartController.value
        .map((i) {
          if (i.product.id == productId) {
            return i.quantity > 1 ? i.copyWith(quantity: i.quantity - 1) : null;
          }
          return i;
        })
        .whereType<CartItem>()
        .toList();
    _cartController.add(current);
  }

  @override
  void removeFromCart(String productId) {
    final current = _cartController.value
        .where((i) => i.product.id != productId)
        .toList();
    _cartController.add(current);
  }

  @override
  void dispose() {
    _cartController.close();
  }

  @override
  bool isInCart(String id) {
    return _cartController.value.any((i) => i.product.id == id);
  }
}
