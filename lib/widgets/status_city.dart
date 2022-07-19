import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/utils/constants.dart';

class StatusAndCity extends StatelessWidget {
  const StatusAndCity({
    Key? key,
    required this.tempDescription,
    required this.weatherIcon,
    required this.description,
    required this.cityName,
  }) : super(key: key);

  final int? tempDescription;
  final String? weatherIcon;
  final String? description;
  final String? cityName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$tempDescription\u2103',
              style: GoogleFonts.roboto(fontSize: 90),
            ),
            Text(
              weatherIcon!,
              style: kConditionTextStyle,
            ),
          ],
        ),
        Text(
          "$cityName",
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "$description",
          style: GoogleFonts.roboto(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
