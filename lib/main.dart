import 'package:flutter/material.dart';
import 'package:park_manager/core/service_locator.dart';
import 'package:park_manager/presentation/navigation_bar.dart';

void main() {
  setup(sl);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const NavigationBarApp(),
    );
  }
}
