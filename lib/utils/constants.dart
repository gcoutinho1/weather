import 'package:flutter/material.dart';

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 90,
);

const kTextFieldInput = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  // icon: Icon(
  //   Icons.location_city,
  //   color: Colors.white,
  // ),
  hintText: 'Digite o nome da cidade',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide.none,
  ),
);
