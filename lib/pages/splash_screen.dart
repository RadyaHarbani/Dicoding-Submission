import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/on_board_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splash();
  }

  _splash() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9E7DC),
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/logos/logo_hug.png",
            width: 100,
          ),
        ),
      ),
    );
  }
}
