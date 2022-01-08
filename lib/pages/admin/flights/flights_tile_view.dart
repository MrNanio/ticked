import 'package:flutter/material.dart';
import 'package:ticked/models/flight.dart';

class FlightsTile extends StatefulWidget {
  FlightsTile({required this.flight});

  final Flight flight;

  @override
  _FlightsTileState createState() => _FlightsTileState();
}

class _FlightsTileState extends State<FlightsTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const Icon(Icons.airplanemode_active),
          title: Text(
              widget.flight.fromCity + '/' + widget.flight.fromIata +' > '+widget.flight.toCity + '/' + widget.flight.toIata),
          subtitle:
              Text(widget.flight.date + '/' + widget.flight.time),
        ),
      ),
    );
  }
}