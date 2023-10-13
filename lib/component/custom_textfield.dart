import 'package:flutter/material.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.prefixIcon,
      required this.hintText,
      this.keyboardType,
      this.suffixIcon,
      this.validator});

  final TextEditingController? controller;
  final bool obscureText;
  final Icon prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final IconButton? suffixIcon;
  final Function? validator;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 3),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.green,
              width: 1.5,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: ConstantApp().figmaFontSize(14),
          ),
          suffixIcon: widget.suffixIcon,
        ),
        cursorColor: Colors.black,
        validator: widget.validator as String? Function(String?)?,
      ),
    );
  }
}
