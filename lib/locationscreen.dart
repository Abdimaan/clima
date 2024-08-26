import 'package:flutter/material.dart';
import 'package:clima/constant.dart';
import 'package:clima/weather.dart';
import 'package:clima/city.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? tempature;
  String? weathericon = '';
  var name;
  String weathermassege = '';

  @override
  void initState() {
    super.initState();
    updateui(widget.locationweather);
  }

  void updateui(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        tempature = 0;
        weathericon = 'error';
        weathermassege = 'unable to get weather data';
        name = '';
        return;
      }
      tempature = weatherdata['main']['temp'].toInt();
      var condition = weatherdata['weather'][0]['id'];
      weathericon =
          condition != null ? weather.getWeatherIcon(condition!) : null;
      weathermassege =
          tempature != null ? weather.getMessage(tempature!) : 'Error';
      name = weatherdata['name'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getlocationweather();
                      updateui(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedname= await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                     if(typedname != null){
                      var weatherData= await weather.getcityname(typedname);
                      updateui(weatherData);
                     }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weathermassege  in $name!",
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
