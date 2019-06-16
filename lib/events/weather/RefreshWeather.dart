import 'package:meta/meta.dart';
import 'package:weather_app/events/weather/WeatherEvent.dart';

class RefreshWeather extends WeatherEvent {
  final String city;

  RefreshWeather({@required this.city})
      : assert(city != null),
        super([city]);
}
