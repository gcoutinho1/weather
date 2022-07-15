import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/utils/api/api_key.dart';

class WeatherModel {
  String getWeatherIcon(int? condition) {
    if (condition != null && condition < 300) {
      return '🌩';
    } else if (condition != null && condition < 400) {
      return '🌧';
    } else if (condition != null && condition < 600) {
      return '☔️';
    } else if (condition != null && condition < 700) {
      return '☃️';
    } else if (condition != null && condition < 800) {
      return '🌫';
    } else if (condition != null && condition == 800) {
      return '☀️';
    } else if (condition != null && condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int? temp) {
    if (temp != null && temp > 20) {
      return 'Ta começando a esquentar 👕';
    } else if (temp != null && temp > 25) {
      return 'Que Calor em, hora de um sorvete 🍦';
    } else if (temp != null && temp < 10) {
      return 'Ta ficando friooo, talvez você precise de luvas 🧤';
    } else {
      return 'Ande com um casaco 🧥';
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetWorkHelper netWorkHelper = NetWorkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await netWorkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetWorkHelper netWorkHelper = NetWorkHelper(url);
    var weatherData = await netWorkHelper.getData();
    return weatherData;
  }
}
