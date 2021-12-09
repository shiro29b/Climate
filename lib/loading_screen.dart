import 'package:climate/weather.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'networking.dart';

class Loadingscreen extends StatefulWidget {
  const Loadingscreen({Key? key}) : super(key: key);

  @override
  _LoadingscreenState createState() => _LoadingscreenState();
}

class _LoadingscreenState extends State<Loadingscreen> {


  @override
  void initState() {
    super.initState();
    getLocationData();

   }

  void getLocationData() async {

        var result= await WeatherModel().getLocationWeather();

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return LocationScreen(result);
        }));

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
