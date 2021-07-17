import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monopoly_map/src/models/property_details.dart';
import 'package:monopoly_map/src/property_details_page.dart';
import 'package:monopoly_map/src/utils/constants.dart';

class GoogleMapWidget extends StatefulWidget {
  final List<PropertyDetails> properties;
  final String budget;
  final double cameraLatitude;
  final double cameraLongitude;

  GoogleMapWidget(this.cameraLatitude, this.cameraLongitude, this.budget, this.properties);
  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;

  // Generates markers with a image and send property details to property details page
  Future<Set<Marker>> generateMarkers() async {
    List<Marker> customMarkers = [];
    int i = 0;

    for(var property in widget.properties) {
      var isAboveBudget = double.parse(property.price) > double.parse(widget.budget);
      final icon = isAboveBudget
          ? await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: size), redHotel)
          : await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: size), greenHouse);

      final marker = Marker(
          markerId: MarkerId('$i'),
          icon: icon,
          position: LatLng(property.latitude, property.longitude),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(property)));
          },
      );

      customMarkers.add(marker);
      i++;
    }
    return customMarkers.toSet();
  }

  CameraPosition mapPosition() {
    return CameraPosition(
      target: LatLng(widget.cameraLatitude, widget.cameraLongitude),
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
              mapController = controller;
            },
          ) : CircularProgressIndicator();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: loadMap(),
    );
  }
}
