import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/offline_screen.dart';
import 'package:weather/screens/search_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utils/constants.dart';
import 'package:weather/widgets/additional_information.dart';
import 'package:weather/widgets/status_city.dart';
import 'package:weather/widgets/weather_message.dart';

class HomeScreen extends StatefulWidget {
  final locationWeather;

  const HomeScreen({Key? key, this.locationWeather}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? weatherIcon;
  String? weatherMessage;
  String? cityName;
  String? description;
  int? tempDescription;
  int? humidity;
  int? wind;
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
          const Image(
            image: CachedNetworkImageProvider(
              kHomeBackgroundImage,
            ),
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
                const SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatusAndCity(
                                tempDescription: tempDescription,
                                weatherIcon: weatherIcon,
                                description: description,
                                cityName: cityName),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    WeatherMessage(message: weatherMessage),
                    Container(
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
                          AdditionalInformation(
                            info: wind,
                            message: "Vento",
                            secondInfo: "km/h",
                            color: Colors.greenAccent,
                            width: 15,
                          ),
                          AdditionalInformation(
                            info: tempMin,
                            message: "Min",
                            secondInfo: "\u2103",
                            color: Colors.greenAccent,
                            width: 20,
                          ),
                          AdditionalInformation(
                            info: tempMax,
                            message: "Max",
                            secondInfo: "\u2103",
                            color: Colors.redAccent,
                            width: 40,
                          ),
                          AdditionalInformation(
                            info: humidity,
                            message: "Umidade",
                            secondInfo: "%",
                            color: Colors.redAccent,
                            width: 23,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
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

  Future checkConnectionInternet() async {
    var connectivity = await (Connectivity().checkConnectivity());
    if (connectivity == ConnectivityResult.none) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OfflineScreen()));
    }
  }
}
