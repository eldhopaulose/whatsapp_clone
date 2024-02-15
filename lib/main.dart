import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Screens/CameraScreen.dart';
import 'package:whatsapp/Screens/LoginSceen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
      home: const LoginScreen(),
    );
  }
}
