import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/WeatherCondition.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;
  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => _mapConditionToImage(condition);

  Image _mapConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
      case WeatherCondition.hail:
        image = Image.asset('assets/forecast-icons/snow.png', height: 80, width: 80);
        break;

      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/forecast-icons/storm.png', height: 80, width: 80);

        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        image = Image.asset('assets/forecast-icons/rain.png', height: 80, width: 80);
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/forecast-icons/cloudy.png', height: 80, width: 80);
        break;
      case WeatherCondition.lightCloud:
      case WeatherCondition.clear:
      case WeatherCondition.unknown:
        image =
            Image.asset('assets/forecast-icons/sun.png', height: 80, width: 80);
        break;
    }
    return image;
  }
}
