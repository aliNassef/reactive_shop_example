import 'package:equatable/equatable.dart';

import '../../models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  const CartState({this.items = const []});

  double get total => items.fold(0, (s, i) => s + i.subtotal);
  int get count => items.fold(0, (s, i) => s + i.quantity);
  bool contains(String id) => items.any((i) => i.product.id == id);

  @override
  List<Object> get props => [items];
}
