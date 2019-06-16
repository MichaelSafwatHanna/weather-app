import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/bloc/ThemeBloc.dart';
import 'package:weather_app/bloc/WeatherBloc.dart';
import 'package:weather_app/events/theme/WeatherChanged.dart';
import 'package:weather_app/events/weather/FetchWeather.dart';
import 'package:weather_app/events/weather/RefreshWeather.dart';
import 'package:weather_app/states/theme/ThemeState.dart';
import 'package:weather_app/states/weather/WeatherEmpty.dart';
import 'package:weather_app/states/weather/WeatherError.dart';
import 'package:weather_app/states/weather/WeatherLoaded.dart';
import 'package:weather_app/states/weather/WeatherLoading.dart';
import 'package:weather_app/states/weather/WeatherState.dart';
import 'package:weather_app/widgets/CitySelection.dart';
import 'package:weather_app/widgets/CombinedWeatherTemperature.dart';
import 'package:weather_app/widgets/LastUpdated.dart';
import 'package:weather_app/widgets/Location.dart';

import 'GradientContainer.dart';

class Weather extends StatefulWidget {
  final WeatherRepository weatherRepository;

  Weather({Key key, this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Weather App'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final city = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CitySelection(),
                  ),
                );
                if (city != null) {
                  _weatherBloc.dispatch(FetchWeather(city: '$city'));
                }
              })
        ]),
        body: Center(
          child: BlocBuilder(
              bloc: _weatherBloc,
              builder: (_, WeatherState state) {
                if (state is WeatherEmpty) {
                  return Center(
                    child: Text("Please Select a Location"),
                  );
                } else if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  final weather = state.weather;
                  final themeBloc = BlocProvider.of<ThemeBloc>(context);
                  themeBloc
                      .dispatch(WeatherChanged(condition: weather.condition));

                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();

                  return BlocBuilder(
                      bloc: themeBloc,
                      builder: (_, ThemeState themeState) {
                        return GradientContainer(
                          color: themeState.color,
                          child: RefreshIndicator(
                            onRefresh: () {
                              _weatherBloc.dispatch(
                                  RefreshWeather(city: state.weather.location));
                              return _refreshCompleter.future;
                            },
                            child: ListView(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 100),
                                  child: Center(
                                    child: Location(location: weather.location),
                                  ),
                                ),
                                Center(
                                  child: LastUpdated(
                                      dateTime: weather.lastUpdated),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.0),
                                  child: Center(
                                    child: CombinedWeatherTemperature(
                                      weather: weather,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                if (state is WeatherError) {
                  return Text('Something went Wrong!',
                      style: TextStyle(color: Colors.red));
                }
              }),
        ));
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}
