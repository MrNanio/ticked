import 'package:flutter/material.dart';

class FlightsWidget extends StatefulWidget {
  const FlightsWidget({Key? key}) : super(key: key);

  @override
  _FlightsWidgetState createState() => _FlightsWidgetState();
}

class _FlightsWidgetState extends State<FlightsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blueGrey,
              child: const SizedBox(
                width: double.infinity,
                height: 200,
                child: Center(child: Text('dodaj lot')),
              )),
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blue,
              child: const SizedBox(
                width: double.infinity,
                height: 300,
                child: Center(child: Text('lista dodanych lotów')),
              )),
        ],
      ),
    );
  }
}
