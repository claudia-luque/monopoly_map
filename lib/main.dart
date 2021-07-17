import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html';
import 'dart:convert';

import 'package:monopoly_map/src/google_map_page.dart';
import 'package:monopoly_map/src/models/property_details.dart';

void main() {
  runApp(MonopolyMap());
}

class MonopolyMap extends StatelessWidget {
  final title = 'Monopoly Map';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final postcodeTextController = TextEditingController();
  final budgetTextController = TextEditingController();
  final maximunPrice = 100000000;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<http.Response> zooplaAPICallAndResponse() async {
    int radius = 1;
    int pageSize = 100;
    String zooplaAPIKey = '<API-KEY-HERE>';
    String zooplaUrl =
        'https://api.zoopla.co.uk/api/v1/property_listings.js'
            + '?listing_status=sale&postcode='
            + '${postcodeTextController.text}'
            + '&maximum_price=${maximunPrice.toString()}'
            + '&radius=$radius'
            + '&page_size='
            + '$pageSize'
            + '&api_key=$zooplaAPIKey';
    return http.get(Uri.parse(zooplaUrl));
  }

  Form createForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: postcodeTextController,
            decoration: const InputDecoration(
              hintText: 'Postcode',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please insert a valid Postcode';
              }
              return null;
            },
          ),
          TextFormField(
            controller: budgetTextController,
            decoration: const InputDecoration(
              hintText: 'Budget',
            ),
            validator: (String? value) {
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                var response = await zooplaAPICallAndResponse();
                window.localStorage['data'] = response.body;
                var jsonData = json.decode(response.body);

                // Getting property details from JSON response body
                List<PropertyDetails> propertyDetailsList = [];
                for(var obj in jsonData['listing']) {
                  PropertyDetails data = new PropertyDetails(
                      obj['county'],
                      obj['image_645_430_url'],
                      obj['property_type'],
                      obj['agent_phone'],
                      obj['status'],
                      obj['price'],
                      obj['latitude'],
                      obj['longitude']);
                  propertyDetailsList.add(data);
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoogleMapWidget(
                            jsonData['latitude'],
                            jsonData['longitude'],
                            budgetTextController.text,
                            propertyDetailsList)),
                );
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Search'),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: SizedBox(
            width: 400,
            child: createForm(),
          ),
        ),
      ],
    );
  }
}
