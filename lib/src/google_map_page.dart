

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'google_map_widget.dart';

class GoogleMapPage extends StatelessWidget {
  final String title = 'Map';
  double latitude;
  double longitude;
  double price;

  // Constructor
  GoogleMapPage(this.latitude, this.longitude, this.price);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: GoogleMapWidgetState().widget,
    );
  }
}