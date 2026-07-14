import 'package:flutter/material.dart';
import 'player_count_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 3초 후 메인 페이지로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PlayerCountScreen()), // MainPage로 이동
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // 배경색
        child: Center(
          child: Image.asset(
            'assets/images/revolver.png', // 이미지 경로
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
