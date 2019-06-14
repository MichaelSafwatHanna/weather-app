import 'package:meta/meta.dart';
import 'package:weather_app/models/Weather.dart';

import 'WeatherState.dart';

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
    : assert(weather!= null), super([weather]);

}