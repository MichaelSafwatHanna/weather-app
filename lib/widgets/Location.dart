import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String location;

  const Location({Key key, @required this.location})
      : assert(location != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(location,
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold));
  }
}
