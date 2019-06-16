import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/widgets/Tempreature.dart';
import 'package:weather_app/widgets/WeatherConditions.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final Weather weather;
  CombinedWeatherTemperature({@required this.weather})
      : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: WeatherConditions(condition: weather.condition),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Temperature(
                    temperature: weather.temp,
                    high: weather.maxTemp,
                    low: weather.minTemp))
          ],
        ),
        Center(
            child: Text(weather.formattedCondition,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w200,
                    color: Colors.white)))
      ],
    );
  }
}
