import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/events/FetchWeather.dart';
import 'package:weather_app/events/WeatherEvent.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/states/WeatherEmpty.dart';
import 'package:weather_app/states/WeatherError.dart';
import 'package:weather_app/states/WeatherLoaded.dart';
import 'package:weather_app/states/WeatherLoading.dart';
import 'package:weather_app/states/WeatherState.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherState currentState,
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}
