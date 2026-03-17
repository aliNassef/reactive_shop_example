import 'package:equatable/equatable.dart';

import '../../models/product.dart';

enum Status { initial, loading, success, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
}

class ProductState extends Equatable {
  final Status status;
  final List<Product> products;
  final Set<String> wishlistedIds;
  final Set<String> cartedIds;

  const ProductState({
    this.status = Status.initial,
    this.products = const [],
    this.wishlistedIds = const {},
    this.cartedIds = const {},
  });

  bool isWishlisted(String id) => wishlistedIds.contains(id);
  bool isCarted(String id) => cartedIds.contains(id);

  ProductState copyWith({
    Status? status,
    List<Product>? products,
    Set<String>? wishlistedIds,
    Set<String>? cartedIds,
  }) => ProductState(
    status: status ?? this.status,
    products: products ?? this.products,
    wishlistedIds: wishlistedIds ?? this.wishlistedIds,
    cartedIds: cartedIds ?? this.cartedIds,
  );

  @override
  List<Object> get props => [products, wishlistedIds, cartedIds];
}
