import 'package:geolocator/geolocator.dart';

import 'location.dart';
import 'networking.dart';

class GetWeather {
  Position position;
  double lat;
  double long;
  String apiKey = 'APIKEY';
  var weatherobj;
  Future<dynamic> GetWeatherFromPosition() async {
    Location loc = Location();
    position = await loc.GetPosition();
    lat = position.latitude;
    long = position.longitude;
    String PositionUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=${apiKey}&units=metric';
    Networking netobj = Networking(url: PositionUrl);
    weatherobj = await netobj.GetWeather();
    return weatherobj;
  }

  Future<dynamic> GetWeatherFromCity(String cityname) async {
    Location loc = Location();
    position = await loc.GetPosition();
    lat = position.latitude;
    long = position.longitude;
    String PositionUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityname}&appid=${apiKey}&units=metric';
    Networking netobj = Networking(url: PositionUrl);
    weatherobj = await netobj.GetWeather();
    return weatherobj;
  }
}

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
