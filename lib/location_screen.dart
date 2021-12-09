import 'package:flutter/material.dart';
import 'constant.dart';
import 'weather.dart';
import 'city_screen.dart';
class LocationScreen extends StatefulWidget {

  LocationScreen(this.locationWeather);
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();


  late int temperature;
  late String condition;
  var cityname;
  late String weatherMessage;




  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(var weatherData){

    setState(() {
      if(weatherData==null) {
        temperature=0;
        condition='Error';
        weatherMessage='Unable to get weather Data';
        cityname='';
        return;

      }

      var temp=weatherData['main']['temp'];
      temperature= temp.toInt();
      var cond=weatherData['weather'][0]['id'].toInt();
      condition= weather.getWeatherIcon(cond);
      cityname=weatherData['name'].toString();
      weatherMessage=weather.getMessage(temperature);


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherdata= await weather.getLocationWeather();
                      updateUI(weatherdata);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedName=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      })

                      );
                      if(typedName!=null){
                        var weatherdata=await weather.getCityWeather(typedName);
                        updateUI(weatherdata);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding:const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "$temperature °C   ",
                        style: kTempTextStyle,
                      ),
                      Text(
                        condition,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $weatherMessage in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



