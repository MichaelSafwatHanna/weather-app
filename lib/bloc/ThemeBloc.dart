import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/events/theme/ThemeEvent.dart';
import 'package:weather_app/events/theme/WeatherChanged.dart';
import 'package:weather_app/models/WeatherCondition.dart';
import 'package:weather_app/states/theme/ThemeState.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(theme: ThemeData.light(), color: Colors.lightBlue);

  @override
  Stream<ThemeState> mapEventToState(
      ThemeState currentState, ThemeEvent event) async* {
        if(event is WeatherChanged){
          yield _mapWeatherConditionToThemeData(event.condition);
        } 
  }

  ThemeState _mapWeatherConditionToThemeData(WeatherCondition condition) {
    ThemeState theme;
    switch (condition) {
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
      case WeatherCondition.hail:
      theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.lightBlueAccent),
            color: Colors.lightBlue);
        break;
      case WeatherCondition.thunderstorm:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
            color: Colors.deepPurple);
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
      theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.indigoAccent),
            color: Colors.indigo);
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.blueGrey),
            color: Colors.grey);
        break;
      case WeatherCondition.lightCloud:
      case WeatherCondition.clear:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.orangeAccent),
            color: Colors.yellow);
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
            theme: ThemeData(primaryColor: Colors.orangeAccent),
            color: Colors.yellow);
        break;
    }
    return theme;
  }
}
