import 'package:meta/meta.dart';

import 'package:weather_app/events/WeatherEvent.dart';

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({@required this.city})
      : assert(city != null),
        super([city]);
}
