import 'di.dart';

final injector = GetIt.instance;

Future<void> injectionContainer() async {
  await _setupCartFeature();
  await _setupWishlistFeature();
  await _setupProductFeature();
}

Future<void> _setupProductFeature() async {
  injector.registerFactory<ProductCubit>(
    () => ProductCubit(
      productsRepo: injector.get<ProductRepo>(),
      wishlistRepo: injector.get<WishlistRepo>(),
      cartRepo: injector.get<CartRepo>(),
    ),
  );
  injector.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
}

Future<void> _setupWishlistFeature() async {
  injector.registerFactory<WishlistCubit>(
    () => WishlistCubit(injector.get<WishlistRepo>(), injector.get<CartRepo>()),
  );
  injector.registerLazySingleton<WishlistRepo>(() => WishListRepoImpl());
}

Future<void> _setupCartFeature() async {
  injector.registerFactory(() => CartCubit(injector.get<CartRepo>()));
  injector.registerLazySingleton<CartRepo>(() => CartRepoImpl());
}
