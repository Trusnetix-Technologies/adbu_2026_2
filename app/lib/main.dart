import 'package:flutter/material.dart';
import 'package:movie_app_2026/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      // ================= LIGHT THEME ==================
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      // ================= DARK THEME ===================
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
