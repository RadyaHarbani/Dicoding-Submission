import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/habit_page.dart';
import 'package:flutter_exercise/pages/home_page.dart';
import 'package:flutter_exercise/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavComponent extends StatefulWidget {
  const BottomNavComponent({super.key});

  @override
  State<BottomNavComponent> createState() => _BottomNavComponentState();
}

int currentIndexBottomNav = 0;

List<BottomNavigationBarItem> listIconNav = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_filled),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.accessibility_new),
    label: 'Habit',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.auto_awesome_mosaic_rounded),
    label: 'Article',
  ),
];

List<Widget> listPageValue = [
  HomePage(),
  HabitPage(),
  ProfilePage(),
];

class _BottomNavComponentState extends State<BottomNavComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPageValue[currentIndexBottomNav],
      bottomNavigationBar: BottomNavigationBar(
        items: listIconNav,
        currentIndex: currentIndexBottomNav,
        onTap: (value) {
          setState(() {
            currentIndexBottomNav = value;
          });
        },
        selectedItemColor: Color.fromARGB(255, 94, 160, 108),
        unselectedItemColor: Colors.grey[500],
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700),
      ),
    );
  }
}
