import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monopoly_map/src/models/property_details.dart';

class GoogleMapWidget extends StatefulWidget {
  List<PropertyDetails> properties = [];

  GoogleMapWidget(this.properties) {
    print("hello");
  }

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState(this.properties);
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  List<PropertyDetails> properties =[];
  String imageUrl = 'images/green_house.png';
  double zoom = 17;
  String markerId = 'bob';
  Size size = Size(64, 49);

  GoogleMapWidgetState(this.properties);

  Future<Set<Marker>> generateMarkers() async {
    List<Marker> customMarkers = [];
    //final icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: size), imageUrl);
    int i = 0;
    for(var property in properties) {
      print(i);
      final icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: size), imageUrl);

      final marker = Marker(
          markerId: MarkerId('$i'),
          icon: icon,
          position: LatLng(property.latitude, property.longitude));
      customMarkers.add(marker);
      i++;
    }

    return customMarkers.toSet();
  }

  // it can be in a init state
  CameraPosition mapPosition() {
    return CameraPosition(
      target: LatLng(51.649532, -0.185563),
      zoom: zoom,
    );
  }

  Widget loadMap() {
    return FutureBuilder<dynamic>(
        future: generateMarkers(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done ?
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mapPosition(),
            markers: snapshot.data,
            onMapCreated: (controller) {
              mapController = controller; // fix this please
            },
          ) : CircularProgressIndicator();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Map'),),
      body: loadMap(),
    );
  }
}