import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CitySelection extends StatefulWidget {
  @override
  State<CitySelection> createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {

  final TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select City')),
      body: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration:
                      InputDecoration(labelText: 'City'),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pop(context, _textEditingController.text);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
