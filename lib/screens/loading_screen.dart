import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/screens/offline_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // var subscription;
  @override
  void initState() {
    checkConnectionInternet();
    getLocationData();
    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult connectivityResult) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.orangeAccent,
          size: 100,
        ),
      ),
    );
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  void checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var weatherData = await WeatherModel().getLocationWeather();
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(locationWeather: weatherData,)));
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(locationWeather: weatherData,)));
    } else if (connectivityResult == ConnectivityResult.none) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OfflineScreen()));
    }
  }
}
