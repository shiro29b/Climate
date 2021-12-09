import 'location.dart';
import 'networking.dart';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityname)async{
    var url='http://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=4db0629391df42a20dd5fb4a183d13bc&units=metric';
    Networkhelper networkhelper =Networkhelper(url);
    dynamic data=await networkhelper.getData();
    return data;


  }

  Future<dynamic> getLocationWeather() async{

    Location location = Location();

    bool x =await location.getcurrentLocation();
  if(x==true) {
    Networkhelper networkhelper = Networkhelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${location
            .latitude}&lon=${location
            .longitude}&appid=4db0629391df42a20dd5fb4a183d13bc&units=metric');
    dynamic data = await networkhelper.getData();
    return data;
  }
   else {
    return null;
  }

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