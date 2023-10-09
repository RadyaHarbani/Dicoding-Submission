import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitPage extends StatelessWidget {
  const HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                  "Radya Harbani",
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
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            context: context,
            builder: (context) {
              return Container(
                height: 700,
                child: Column(
                  children: [],
                ),
              );
            },
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
