import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  double latitude = 51.649532;
  double longitude = -0.185563;
  String imageUrl = 'images/green_house.png';
  double zoom = 17;
  String markerId = 'bob';
  Size size = Size(64, 49);

  Future<Set<Marker>> generateMarkers() async {
    List<Marker> customMarkers = [];
    final icon = await BitmapDescriptor
        .fromAssetImage(ImageConfiguration(size: size), imageUrl);

    final marker = Marker(
        markerId: MarkerId(markerId),
        icon: icon,
        position: LatLng(latitude, longitude));
    customMarkers.add(marker);
    return customMarkers.toSet();
  }

  // it can be in a init state
  CameraPosition mapPosition() {
    return CameraPosition(
      target: LatLng(latitude, longitude),
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