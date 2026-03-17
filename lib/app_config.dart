import 'package:eda_example/injection_container.dart';
import 'package:flutter/material.dart';

abstract class AppConfig {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await injectionContainer();
  }
}
