import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

TextEditingController? cTitleHabit;
TextEditingController? cNoteHabit;
bool isLoadingHabit = false;
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _HabitPageState extends State<HabitPage> {
  Future<Map<String, dynamic>> addHabit(Map<String, dynamic> data) async {
    try {
      var hasil = await firestore.collection("habit").add(data);

      await firestore.collection("habit").doc(hasil.id).update({
        "habitId": hasil.id,
      });
      return {
        "error": false,
        "message": "Successfully added habit",
      };
    } catch (e) {
      print(e);
      return {
        "error": true,
        "message": "Sorry, habit failed to add",
      };
    }
  }

  @override
  void initState() {
    super.initState();
    cTitleHabit = new TextEditingController();
    cNoteHabit = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    figmaFontSize(int fontSize) {
      return fontSize * 0.95;
    }

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
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            context: context,
            builder: (context) {
              return Container(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "Add Habit",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Title",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: cTitleHabit,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ),
                          ),
                          hintText: "Title",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: figmaFontSize(16),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Note",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: cNoteHabit,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.5,
                            ),
                          ),
                          hintText: "Note",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: figmaFontSize(16),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        if (cTitleHabit!.text.isNotEmpty &&
                            cNoteHabit!.text.isNotEmpty) {
                          Map<String, dynamic> hasil = await addHabit({
                            "Title": cTitleHabit!.text,
                            "Note": cNoteHabit!.text,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                hasil["error"] == true ? "Error" : "Success",
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Error",
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          width: double.infinity,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF375A5A),
                          ),
                          child: Center(
                            child: Text(
                              "Add Habit",
                              style: GoogleFonts.poppins(
                                color: Color(0xFFFAFAFA),
                                fontSize: figmaFontSize(15),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
