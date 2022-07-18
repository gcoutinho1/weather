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
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sem conexão com a internet"),
            ElevatedButton(
                onPressed: () async {
                  checkConnectionInternet();
                },
                child: const Text("Atualizar")),
          ],
        ),
      ),
    );
  }

  void checkConnectionInternet() async {
    var connectivity = await (Connectivity().checkConnectivity());
    var weatherData = await WeatherModel().getLocationWeather();
    if (connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            locationWeather: weatherData,
          ),
        ),
      );
    } else if (connectivity == ConnectivityResult.none) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OfflineScreen()),
      );
    }
  }
}
