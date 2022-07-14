import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              getLocation();
            },
            child: Text('Sua localização')),
      ),
    );
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    // var url = Uri.parse('https://samples.openweathermap.org/data/2.5/weather');
    http.Response response = await http.get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22'));

    if (response.statusCode == 200) {
      String data = response.body;

      var longitude = jsonDecode(data)['coord']['lon'];
      // print(longitude);

      int weatherDescription = jsonDecode(data)['weather'][0]['id'];
      double tempDescription = jsonDecode(data)['main']['temp'];
      String cityDescription = jsonDecode(data)['name'];

      print('cidade: $cityDescription');
      print('temperatura: $tempDescription');
      print('id: $weatherDescription');
    } else {
      print(response.statusCode);
    }
  }
}
