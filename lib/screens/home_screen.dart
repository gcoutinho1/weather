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
  String? weatherIcon;
  String? weatherMessage;
  int? tempDescription;
  String? cityName;
  int? humidity;
  int? wind;
  String? description;
  int? tempMin;
  int? tempMax;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    checkConnectionInternet();
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
        description = '';
        weatherIcon = '';
        weatherMessage = 'Não foi possível acessar os dados';
        cityName = '';
        humidity = 0;
        wind = 0;
        tempDescription = 0;
        tempMin = 0;
        tempMax = 0;
        return;
      } else {
        cityName = weatherData['name'];
        humidity = weatherData['main']['humidity'];
        description = weatherData['weather'][0]['description'];
        double? temp = weatherData['main']['temp'];
        tempDescription = temp?.toInt();
        double? tempMini = weatherData['main']['temp_min'];
        tempMin = tempMini?.toInt();
        double? tempMaxi = weatherData['main']['temp_max'];
        tempMax = tempMaxi?.toInt();
        double? windSpeed = weatherData['wind']['speed'];
        wind = windSpeed?.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMessage = weatherModel.getMessage(tempDescription);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () async {
              var typedCity = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
              // print(typedCity);
              if (typedCity != null) {
                var weatherData = await weatherModel.getCityWeather(typedCity);
                updateUI(weatherData);
              }
            },
            icon: const Icon(Icons.search)),
        actions: [
          IconButton(
              onPressed: () async {
                checkConnectionInternet();
                var weatherData = await weatherModel.getLocationWeather();
                updateUI(weatherData);
              },
              icon: const Icon(Icons.near_me))
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            'https://images.pexels.com/photos/1229042/pexels-photo-1229042.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  /// ERRO AQUI na Column
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Column(
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
                                    // '☀️',
                                    style: kConditionTextStyle,
                                  ),
                                ],
                              ),
                              Text(
                                "$description",
                                style: GoogleFonts.roboto(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$cityName",
                                style: GoogleFonts.roboto(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$weatherMessage",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.roboto(fontSize: 25),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        //TODO: fix overflowing RenderFlex
                        margin: const EdgeInsets.symmetric(vertical: 25),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Vento",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "$wind",
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "km/h",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 15,
                                      color: Colors.greenAccent,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Min",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "$tempMin",
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\u2103",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 20,
                                      color: Colors.greenAccent,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Max",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "$tempMax",
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\u2103",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 43,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Umidade",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "$humidity",
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "%",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      height: 5,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future checkConnectionInternet() async {
    var connectivity = await (Connectivity().checkConnectivity());
    if (connectivity == ConnectivityResult.none) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OfflineScreen()));
    }
  }
}
