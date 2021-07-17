
import 'package:flutter/material.dart';
import 'package:monopoly_map/src/models/property_details.dart';

class DetailsPage extends StatefulWidget {
  final PropertyDetails propertyDetails;

  DetailsPage(this.propertyDetails);

  @override
  State<StatefulWidget> createState()  => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Property Details')),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16,),
              Image.network('${widget.propertyDetails.image}', width: 480,),
              SizedBox(height: 16,),
              Text('Property Details:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 16,),
              Text('County: ${widget.propertyDetails.county}', style: TextStyle(fontSize: 14)),
              Text('Agent phone: ${widget.propertyDetails.agentPhone}', style: TextStyle(fontSize: 14)),
              Text('Status: ${widget.propertyDetails.status}', style: TextStyle(fontSize: 14)),
              Text('Property type: ${widget.propertyDetails.propertyType}', style: TextStyle(fontSize: 14)),
              Text('Price: £${widget.propertyDetails.price}', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}