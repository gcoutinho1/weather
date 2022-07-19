import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherMessage extends StatelessWidget {
  const WeatherMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$message",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ],
    );
  }
}
