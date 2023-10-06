import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/login_page.dart';
import 'package:flutter_exercise/pages/register_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  figmaFontSize(int fontSize) {
    return fontSize * 0.95;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Image.asset("assets/logos/logo_hug_horizontal.png"),
          ),
          SizedBox(
            height: 140,
          ),
          Center(child: Image.asset("assets/images/on_board4.png")),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 250,
              child: Text(
                "Hi there, Glad to see you’re on your way to a better life!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 76, 76, 76),
                    fontSize: figmaFontSize(18),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Do you have an account?",
              style: TextStyle(
                color: Color(0xFF161616),
                fontSize: figmaFontSize(20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
                child: Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFF375A5A),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Color(0xFFFAFAFA),
                        fontSize: figmaFontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                ),
                child: Container(
                  width: 120,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF0EF),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Color(0xFF357658),
                        fontSize: figmaFontSize(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
