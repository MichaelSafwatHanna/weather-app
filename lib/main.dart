import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/App.dart';
import 'package:weather_app/WeatherApiClient.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:http/http.dart' as http;

import 'bloc/SimpleBLocDelegate.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App(weatherRepository: weatherRepository));
}
