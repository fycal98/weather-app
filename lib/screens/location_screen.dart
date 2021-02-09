import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weather);
  var weather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temp;
  int condition;
  String city;
  String icon;
  String message;
  Response weather;
  void getweathetinfo() {
    wea = weather;
    wea = jsonDecode(wea.body);
    if (wea != null) {
      condition = wea['weather'][0]['id'];
      city = wea['name'];
      temp = wea['main']['temp'].toInt();
      WeatherModel w = WeatherModel();
      icon = w.getWeatherIcon(condition);

      message = w.getMessage(temp);
      print(city);

      return;
    }
    temp = 0;
    icon = 'ERROR';
    city = '';
    message = 'no available informations';
  }

  var wea;
  @override
  void initState() {
    weather = widget.weather;
    setState(() {
      getweathetinfo();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
                  FlatButton(
                    onPressed: () async {
                      GetWeather we = GetWeather();
                      weather = await we.GetWeatherFromPosition();
                      setState(() {
                        getweathetinfo();
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      weather = await Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return CityScreen();
                      }));
                      setState(() {
                        getweathetinfo();
                      });
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
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  "$message in $city!",
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
