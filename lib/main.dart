import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // 스플래시 화면 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Russian Roulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // 첫 화면을 SplashScreen으로 설정
    );
  }
}
