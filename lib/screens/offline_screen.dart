import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/services/weather.dart';

class OfflineScreen extends StatefulWidget {
  const OfflineScreen({Key? key}) : super(key: key);

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO: implements refresh
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sem conexão"),
            ElevatedButton(
                onPressed: () async {
                  checkConnectionInternet();
                },
                child: Text("Atualizar")),
          ],
        ),
      ),
    );
  }

  void checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var weatherData = await WeatherModel().getLocationWeather();
    if (connectivityResult == ConnectivityResult.mobile) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(locationWeather: weatherData,)));
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(locationWeather: weatherData,)));
    } else if (connectivityResult == ConnectivityResult.none) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OfflineScreen()));
    }
  }
}
