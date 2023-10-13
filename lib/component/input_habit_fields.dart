import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

figmaFontSize(int fontSize) {
  return fontSize * 0.95;
}

class InputHabitField extends StatelessWidget {
  const InputHabitField({
    super.key,
    required this.title,
    required this.hint,
    this.height,
    this.maxLines,
    this.controller,
    this.widget,
  });

  final String title;
  final String hint;
  final double? height;
  final int? maxLines;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: figmaFontSize(16),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            height: height == null ? 52 : height,
            padding: EdgeInsets.only(
              left: 15,
              top: 1,
              bottom: 1,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    maxLines: maxLines == null ? 1 : maxLines,
                    autofocus: false,
                    cursorColor: Colors.black,
                    controller: controller,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: figmaFontSize(15),
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(15),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
