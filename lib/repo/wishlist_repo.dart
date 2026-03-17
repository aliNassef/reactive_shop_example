import 'package:rxdart/rxdart.dart';

import '../models/product.dart';

abstract class WishlistRepo {
  Stream<List<Product>> get wishlistStream;
  void toggleWishlist(Product product);
  void removeFromWishlist(Product product);
  bool isWishlisted(String id);

  void dispose();
}

class WishListRepoImpl extends WishlistRepo {
  final _wishlistController = BehaviorSubject<List<Product>>.seeded(const []);
  @override
  Stream<List<Product>> get wishlistStream => _wishlistController.stream;

  @override
  bool isWishlisted(String id) =>
      _wishlistController.value.any((p) => p.id == id);
  @override
  void toggleWishlist(Product product) {
    final current = List<Product>.from(_wishlistController.value);
    final exists = current.any((p) => p.id == product.id);
    exists
        ? current.removeWhere((p) => p.id == product.id)
        : current.add(product);
    _wishlistController.add(current);
  }

  @override
  void removeFromWishlist(Product product) {
    final current = _wishlistController.value
        .where((p) => p.id != product.id)
        .toList();
    _wishlistController.add(current);
  }

  @override
  void dispose() {
    _wishlistController.close();
  }
}
