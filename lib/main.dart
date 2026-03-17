import 'package:eda_example/app_config.dart';
import 'package:eda_example/views/shop_shell._view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di.dart';
import 'injection_container.dart';

void main() async {
  await AppConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => injector<ProductCubit>()..getProducts(),
          ),
          BlocProvider(create: (context) => injector<WishlistCubit>()),
          BlocProvider(create: (context) => injector<CartCubit>()),
        ],
        child: ShopShell(),
      ),
    );
  }
}
