import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/component/input_habit_bottom_sheet.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:flutter_exercise/pages/login_page.dart';
import 'package:flutter_exercise/pages/profile_page.dart';
import 'package:flutter_exercise/pages/register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFD9E7DC),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello 👋",
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                isGoogleSignIn || isGoogleSignUp
                                    ? FirebaseAuth
                                        .instance.currentUser!.displayName
                                        .toString()
                                    : isEmailSignIn
                                        ? cNameSignIn!.text.toString()
                                        : cNameSignUp!.text.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.person)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMMd().format(
                                DateTime.now(),
                              ),
                              style: GoogleFonts.poppins(
                                fontSize:ConstantApp(). figmaFontSize(15),
                                fontWeight: FontWeight.w500,
                                height: 0.8,
                              ),
                            ),
                            Text(
                              "Today",
                              style: GoogleFonts.poppins(
                                fontSize:ConstantApp(). figmaFontSize(20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 15,
                      bottom: 10,
                    ),
                    child: Container(
                      child: DatePicker(
                        DateTime.now(),
                        monthTextStyle: GoogleFonts.poppins(
                          fontSize:ConstantApp(). figmaFontSize(15),
                          fontWeight: FontWeight.w500,
                        ),
                        dateTextStyle: GoogleFonts.poppins(
                          fontSize:ConstantApp(). figmaFontSize(20),
                          fontWeight: FontWeight.w500,
                        ),
                        dayTextStyle: GoogleFonts.poppins(
                          fontSize:ConstantApp(). figmaFontSize(15),
                          fontWeight: FontWeight.w500,
                        ),
                        width: 65,
                        height: 95,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Color(0xFF375A5A),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            builder: (context) => InputHabitBottomSheet(),
          );
        },
        child: Container(
          width: 140,
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF375A5A),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_rounded,
                color: Color(0xFFFAFAFA),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "New Habit",
                style: GoogleFonts.poppins(
                    color: Color(0xFFFAFAFA), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
