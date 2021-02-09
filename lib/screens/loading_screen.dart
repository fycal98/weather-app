import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getPosition();
  }

  void getPosition() async {
    GetWeather weather = GetWeather();

    var pos = await weather.GetWeatherFromPosition();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return LocationScreen(pos);
    }));
    //var pos = await weather.GetWeatherFromPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}
