import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/di/main_module.dart';

import 'navigation/main_router.dart';

void main() {
  MainModule.initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Event Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: mainRouter,
    );
  }
}
