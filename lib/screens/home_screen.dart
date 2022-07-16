import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/screens/offline_screen.dart';
import 'package:weather/screens/search_screen.dart';
import 'package:weather/services/weather.dart';

import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final locationWeather;

  const HomeScreen({Key? key, this.locationWeather}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String weatherIcon;
  late String weatherMessage;
  int? tempDescription;
  String? cityDescription;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // checkConnectionInternet();
    updateUI(widget.locationWeather);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        tempDescription = 0;
        weatherIcon = '';
        weatherMessage = 'Não foi possível acessar os dados';
        cityDescription = '';
        return;
      } else {
        double? temp = weatherData['main']['temp'];
        tempDescription = temp?.toInt();
        cityDescription = weatherData['name'];
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMessage = weatherModel.getMessage(tempDescription);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //     icon: Icon(
      //       Icons.near_me,
      //       // size: 50,
      //     ),
      //     label: 'Update'
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(
      //       Icons.location_city,
      //       // size: 50,
      //     ),
      //     label: 'Pesquisar'
      //   )
      // ]),
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
                    onPressed: () async {
                      checkConnectionInternet();
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 50,
                    ),
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()));
                      // print(typedCity);
                      if (typedCity != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const OfflineScreen()));
                  //   },
                  //   icon: Icon(Icons.local_activity),
                  // ),
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
                    Text(
                      weatherIcon,
                      // '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "$weatherMessage \nem $cityDescription",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future checkConnectionInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OfflineScreen()));
    }
  }
}
