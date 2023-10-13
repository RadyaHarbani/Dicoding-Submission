import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/component/input_habit_fields.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:flutter_exercise/model/models_habit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InputHabitBottomSheet extends StatefulWidget {
  const InputHabitBottomSheet({super.key});

  @override
  State<InputHabitBottomSheet> createState() => _InputHabitBottomSheetState();
}

TextEditingController? cTitleHabit;
TextEditingController? cNoteHabit;
bool isLoadingHabit = false;
int selectedCategory = 0;
String selectedCategoryName = "Productive";
DateTime selectedDate = DateTime.now();
String selectedTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

class _InputHabitBottomSheetState extends State<InputHabitBottomSheet> {
  Future<void> addHabit({Habit? habit}) async {
    try {
      var hasil = await FirebaseFirestore.instance
          .collection("habitApp")
          .add(habit!.toMap());
      await hasil.collection("habitApp").doc(hasil.id).update({
        "habitId": hasil.id,
      });
    } catch (e) {
      print(e);
    }
  }

  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  getTimeFromUser() async {
    var pickedTime = await showTimePickerInput();

    if (pickedTime == null) {
      print("Time is not selected");
    } else {
      var formatedTime = pickedTime.format(context);

      setState(() {
        selectedTime = formatedTime;
      });
    }
  }

  getCategoryFromUser() {
    switch (selectedCategory) {
      case 0:
        selectedCategoryName = "Productive";
        break;
      case 1:
        selectedCategoryName = "Healthy";
        break;
      case 2:
        selectedCategoryName = "Hobby";
        break;
    }
  }

  showTimePickerInput() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(selectedTime.split(":")[0]),
        minute: int.parse(selectedTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  validateHabit() async {
    if (cTitleHabit!.text.isNotEmpty && cNoteHabit!.text.isNotEmpty) {
      addHabit(
        habit: Habit(
          title: cTitleHabit!.text,
          note: cNoteHabit!.text,
          date: DateFormat.yMd().format(selectedDate).toString(),
          selectedTime: selectedTime,
          isCompleted: 0,
          category: selectedCategoryName,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Success",
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
  }

  @override
  void initState() {
    super.initState();
    cTitleHabit = new TextEditingController();
    cNoteHabit = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 20,
              ),
              child: Text(
                "Add Habit",
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InputHabitField(
              title: "Title",
              hint: "Enter yout title",
              controller: cTitleHabit,
            ),
            SizedBox(
              height: 10,
            ),
            InputHabitField(
              title: "Note",
              height: 140,
              maxLines: 10,
              hint: "Enter your note",
              controller: cNoteHabit,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InputHabitField(
                    title: "Start Time",
                    hint: selectedTime,
                    widget: IconButton(
                      onPressed: () {
                        getTimeFromUser();
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InputHabitField(
                    title: "Date",
                    hint: DateFormat.yMd()
                        .format(
                          selectedDate,
                        )
                        .toString(),
                    widget: IconButton(
                      onPressed: () {
                        getDateFromUser();
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        "Category",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: List<Widget>.generate(
                        3,
                        (int index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? Colors.green
                                      : index == 1
                                          ? Colors.blue
                                          : Colors.orange,
                                  child: selectedCategory == index
                                      ? Icon(
                                          Icons.done_rounded,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  index == 0
                                      ? "Productive"
                                      : index == 1
                                          ? "Healthy"
                                          : "Hobby",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      getCategoryFromUser();
                      validateHabit();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF375A5A),
                      ),
                      child: Center(
                        child: Text(
                          "Add Habit",
                          style: GoogleFonts.poppins(
                            color: Color(0xFFFAFAFA),
                            fontSize:ConstantApp(). figmaFontSize(15),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFF375A5A),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF375A5A),
                            fontSize: ConstantApp(). figmaFontSize(15),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
