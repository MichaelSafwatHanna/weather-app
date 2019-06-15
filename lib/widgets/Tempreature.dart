import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class Temperature extends StatelessWidget {
  final double temperature;
  final double high;
  final double low;

  Temperature({Key key, this.temperature, this.high, this.low})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            '${_formattedTemperature(temperature)}°',
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              '${_formattedTemperature(high)}°',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
            ),
            Text(
              '${_formattedTemperature(low)}°',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w100),
            ),
          ],
        )
      ],
    );
  }

  int _formattedTemperature(double t) => t.round();
}
