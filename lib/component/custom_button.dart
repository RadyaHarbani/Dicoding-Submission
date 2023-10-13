import 'package:flutter/material.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.isEmailOrGoogle,
    required this.child,
    required this.isColor,
  });

  final Function onTap;
  final bool isEmailOrGoogle;
  final Widget child;
  final bool isColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          width: double.infinity,
          height: widget.isEmailOrGoogle ? 70 : 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                widget.isColor == true ? Color(0xFF375A5A) : Colors.transparent,
            border: widget.isColor == false
                ? Border.all(
                    color: Color(0xFF375A5A),
                    width: 1.3,
                  )
                : null,
          ),
          child: Center(
            child: widget.isEmailOrGoogle
                ? Center(
                    child: Text(
                      "Loading...",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: ConstantApp().figmaFontSize(17),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : widget.child,
          ),
        ),
      ),
    );
  }
}
