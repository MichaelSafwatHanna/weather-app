import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/widgets/Weather.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        home: Weather(weatherRepository: weatherRepository));
  }
}
