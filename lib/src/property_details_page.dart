
import 'package:flutter/material.dart';
import 'package:monopoly_map/src/models/property_details.dart';

class DetailsPage extends StatelessWidget {
  PropertyDetails propertyDetails;

  DetailsPage(this.propertyDetails);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Property Details",
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Center(
        child: Scaffold(
          appBar: AppBar(title: Text('Property Details')),
          body: ListView(
            children: [
              Container(
                height: 600,
                width: 400,
                child: Image.network('${propertyDetails.image}'),
              ),
              Container(
                height: 30,
                child: Text('Property details:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                height: 20,
                child: Text('County: ${propertyDetails.county}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Agent phone: ${propertyDetails.agentPhone}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Status: ${propertyDetails.status}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Property type: ${propertyDetails.propertyType}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('price: ${propertyDetails.price}',
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
    )
    );
  }
}