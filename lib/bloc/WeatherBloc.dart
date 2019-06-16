import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/events/weather/FetchWeather.dart';
import 'package:weather_app/events/weather/RefreshWeather.dart';
import 'package:weather_app/events/weather/WeatherEvent.dart';
import 'package:weather_app/models/Weather.dart';
import 'package:weather_app/states/weather/WeatherEmpty.dart';
import 'package:weather_app/states/weather/WeatherError.dart';
import 'package:weather_app/states/weather/WeatherLoaded.dart';
import 'package:weather_app/states/weather/WeatherLoading.dart';
import 'package:weather_app/states/weather/WeatherState.dart';

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
    
    if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield currentState;
      }
    }
  }
}
