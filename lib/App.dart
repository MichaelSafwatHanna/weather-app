import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/bloc/ThemeBloc.dart';
import 'package:weather_app/states/theme/ThemeState.dart';
import 'package:weather_app/widgets/Weather.dart';

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            theme: themeState.theme,
            color: themeState.color,
            home: Weather(weatherRepository: widget.weatherRepository),
          );
        },
      ),
    );
  }

  @override
  void dispose(){
    _themeBloc.dispose();
    super.dispose();
  }
}
