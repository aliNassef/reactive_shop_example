import '../models/product.dart';

abstract class ProductRepo {
  Future<List<Product>> getProducts();
}

class ProductRepoImpl extends ProductRepo {
  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(
        id: '1',
        name: 'Air Max 270',
        category: 'Shoes',
        price: 149.99,
        emoji: '👟',
      ),
      Product(
        id: '2',
        name: 'Leather Jacket',
        category: 'Outerwear',
        price: 299.99,
        emoji: '🧥',
      ),
      Product(
        id: '3',
        name: 'Slim Chinos',
        category: 'Pants',
        price: 89.99,
        emoji: '👖',
      ),
      Product(
        id: '4',
        name: 'Polo Shirt',
        category: 'Tops',
        price: 59.99,
        emoji: '👕',
      ),
      Product(
        id: '5',
        name: 'Canvas Tote',
        category: 'Accessories',
        price: 39.99,
        emoji: '👜',
      ),
      Product(
        id: '6',
        name: 'Wool Beanie',
        category: 'Accessories',
        price: 29.99,
        emoji: '🧢',
      ),
    ];
  }
}
