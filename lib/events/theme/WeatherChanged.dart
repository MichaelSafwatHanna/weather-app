import 'package:flutter/material.dart';
import 'package:weather_app/events/theme/ThemeEvent.dart';
import 'package:weather_app/models/WeatherCondition.dart';

class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  WeatherChanged({@required this.condition})
      : assert(condition != null),
        super([condition]);
}
