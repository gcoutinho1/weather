import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation(
      {Key? key,
      required this.info,
      required this.message,
      required this.secondInfo,
      required this.color,
      required this.width})
      : super(key: key);

  final int? info;
  final String? message;
  final String? secondInfo;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$message",
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "$info",
          style: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "$secondInfo",
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Stack(
          children: [
            Container(
              height: 5,
              width: 50,
              color: Colors.grey,
            ),
            Container(
              height: 5,
              width: width,
              color: color,
            ),
          ],
        )
      ],
    );
  }
}
