import 'package:equatable/equatable.dart';

import '../../models/product.dart';

class WishlistState extends Equatable {
  final List<Product> items;
  const WishlistState({this.items = const []});

  bool contains(String id) => items.any((p) => p.id == id);
  int get count => items.length;

  @override
  List<Object> get props => [items];
}
