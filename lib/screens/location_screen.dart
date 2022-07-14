import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int? weatherDescription;
  int? tempDescription;
  String? cityDescription;
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    weatherDescription = weatherData['weather'][0]['id'];
    double? temp = weatherData['main']['temp'];
    tempDescription = temp?.toInt();
    cityDescription = weatherData['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   // image: DecorationImage(
        //   //   image: AssetImage('images/location_background.jpg'),
        //   //   fit: BoxFit.cover,
        //   //   colorFilter: ColorFilter.mode(
        //   //       Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   // ),
        // ),
        // constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.near_me,
                      size: 50,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempDescription°',
                      style: GoogleFonts.roboto(fontSize: 100),
                    ),
                    const Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "😇️ Calor em!",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.roboto(fontSize: 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
