import 'package:flutter/material.dart';
import 'package:clima/locationscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/weather.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    getLocationAndData();
  }

 void getLocationAndData() async {
  WeatherModel weatherModel = WeatherModel(); // Create an instance
  var weatherData = await weatherModel.getlocationweather(); // Call the method on the instance

  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return LocationScreen(
      locationweather: weatherData,
    );
  }));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}