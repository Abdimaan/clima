import 'package:clima/location.dart';
import 'package:clima/network.dart';
const apiKey = '424a0f2cc0895670f3d65e4e59df8e1e';
const openwethermap='https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future <dynamic> getcityname(String cityname) async{
  
  NetworkHelper helpe = await NetworkHelper('$openwethermap?q=$cityname&appid=$apiKey&units=metric');
  var weatherData= helpe.getData();
  return weatherData;
  }

Future<dynamic> getlocationweather() async{
  Location loca = Location();
    await loca.getCurrentLocation();
    
    NetworkHelper helper = NetworkHelper(
      '$openwethermap?lat=${loca.latitude}&lon=${loca.longitude}&appid=$apiKey&units=metric',
    );

    var weatherData = await helper.getData();
    return weatherData;
}
  
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
