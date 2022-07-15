import 'package:flutter/material.dart';
import 'package:weather/utils/constants.dart';
// import 'package:clima/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/city_background.jpg'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: kTextFieldInput,
                  onChanged: (value) {
                    // print(value);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Get Weather',
                  // style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// © 2022

