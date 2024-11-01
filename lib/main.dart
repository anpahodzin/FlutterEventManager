import 'package:flutter/material.dart';
import 'package:flutter_event_manager/core/di/MainModule.dart';

import 'navigation/main_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MainModule.initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    //     useMaterial3: true,
    //   ),
    //   home: const HomePage(title: 'Flutter Events Manager'), //todo
    // );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: mainRouter,
    );
  }
}
