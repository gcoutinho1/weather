import 'package:flutter/material.dart';
import 'package:weather/utils/constants.dart';
// import 'package:clima/utilities/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? cityName;

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
                    cityName = value;
                    // print(value);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Obter previsão do tempo',
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

