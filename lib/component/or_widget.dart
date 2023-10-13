import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Color(0xFF0F110E),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Or",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F110E),
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Color(0xFF0F110E),
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
