
import 'package:flutter/material.dart';
import 'package:monopoly_map/src/models/property_details.dart';

class DetailsPage extends StatefulWidget {
  PropertyDetails propertyDetails;
  DetailsPage(this.propertyDetails);

  @override
  State<StatefulWidget> createState()  => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
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
                child: Image.network('${widget.propertyDetails.image}'),
              ),
              Container(
                height: 30,
                child: Text('Property details:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                height: 20,
                child: Text('County: ${widget.propertyDetails.county}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Agent phone: ${widget.propertyDetails.agentPhone}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Status: ${widget.propertyDetails.status}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('Property type: ${widget.propertyDetails.propertyType}',
                    style: TextStyle(fontSize: 14)),
              ),
              Container(
                height: 20,
                child: Text('price: ${widget.propertyDetails.price}',
                    style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
    )
    );
  }
}