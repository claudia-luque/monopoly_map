import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:monopoly_map/src/models/property_details.dart';
import 'package:monopoly_map/src/property_details_page.dart';

class GoogleMapWidget extends StatefulWidget {
  List<PropertyDetails> properties = [];
  String budget;
  double cameraLatitude;
  double cameraLongitude;

  GoogleMapWidget(this.cameraLatitude, this.cameraLongitude, this.budget, this.properties);

  @override
  State<GoogleMapWidget> createState() => GoogleMapWidgetState(this.cameraLatitude, this.cameraLongitude, this.budget, this.properties);
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;
  List<PropertyDetails> properties =[];
  double cameraLatitude;
  double cameraLongitude;
  String budget;
  String greenHouse = 'images/green_house.png';
  String redHotel = 'images/red_hotel.png';
  double zoom = 17;
  String markerId = 'bob';
  Size size = Size(64, 49);

  GoogleMapWidgetState(this.cameraLatitude, this.cameraLongitude, this.budget, this.properties);

  Future<Set<Marker>> generateMarkers() async {
    List<Marker> customMarkers = [];
    int i = 0;

    for(var property in properties) {
      var isAboveBudget = double.parse(property.price) > double.parse(budget);
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
                  builder: (context) => DetailsPage(property)),
            );
          },
      );

      customMarkers.add(marker);
      i++;
    }


    return customMarkers.toSet();
  }

  // TODO: it can be in a init state
  CameraPosition mapPosition() {
    return CameraPosition(
      target: LatLng(cameraLatitude, cameraLongitude),
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
      appBar: AppBar(title: Text('Map'),),
      body: loadMap(),
    );
  }
}
