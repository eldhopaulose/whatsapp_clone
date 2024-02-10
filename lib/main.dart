import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/Homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF075E54),
          primary: Color(0xFF075E54),
          secondary: Color(0xFF075E54),
        ),
        useMaterial3: false,
        fontFamily: "OpenSans",
      ),
      home: const Homescreen(),
    );
  }
}
