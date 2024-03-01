import 'package:flutter/material.dart';
import 'package:tcc_app/Screens/HomePage.dart';
import 'package:tcc_app/Screens/LoginForm.dart';
import 'package:tcc_app/Screens/flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nature Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/home': (context) => const FlutterPage(),
      },
    );
  }
}
