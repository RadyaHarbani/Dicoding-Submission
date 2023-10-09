import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/firebase/firebase_options.dart';
import 'package:flutter_exercise/pages/bottom_nav_component.dart';
import 'package:flutter_exercise/pages/habit_page.dart';
import 'package:flutter_exercise/pages/login_page.dart';
import 'package:flutter_exercise/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
