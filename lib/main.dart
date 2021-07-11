import 'package:flutter/material.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
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
                    decoration: const InputDecoration(
                      hintText: 'Budget',
                    ),
                    validator: (String? value) {
                      // checking if the value inserted is a valid number
                      bool isInteger(num val) => val is int || val == val.roundToDouble();
                      var number = int.parse(value.toString());
                      if (isInteger(number)) {
                        return 'Please input a valid number';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //TODO: call my API

                        if (_formKey.currentState!.validate()) {
                          // Process data.
                        }
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

