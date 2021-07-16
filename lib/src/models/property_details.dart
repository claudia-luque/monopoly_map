import 'package:flutter/cupertino.dart';

class PropertyDetails {
  final String county;
  final String image;
  final String propertyType;
  final String agentPhone;
  final String status;
  final String price;
  final double latitude;
  final double longitude;


  PropertyDetails(this.county, this.image, this.propertyType, this.agentPhone,
      this.status, this.price, this.latitude, this.longitude);

  // constructor, for constructing a new property details instance from a map structure.
  // PropertyDetails.fromJson(Map<String, dynamic> json):
  //   county = json['county'],
  //   image = json['image_645_430_url'],
  //   propertyType = json['property_type'],
  //   agentPhone = json['agent_phone'],
  //   status = json['status'],
  //   price = json['price'];

  // method, which converts a property details instance into a map
  // Map<String, dynamic> toJson() => {
  //   'county': county,
  //   'image_645_430_url': image,
  //   'property_type': propertyType,
  //   'agent_phone': agentPhone,
  //   'status': status,
  //   'price': price
  // };
  
}