import 'package:flutter/material.dart';
import 'package:ticked/models/flight.dart';

class FlightTile extends StatefulWidget {
  //const FlightTile({Key? key}) : super(key: key);

  FlightTile({required this.flight});

  final Flight flight;

  @override
  _FlightTileState createState() => _FlightTileState();

}

class _FlightTileState extends State<FlightTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
          ),
          title: Text('Data lotu: ${widget.flight.date}, ${widget.flight.time}'),
          subtitle: Text('Z ${widget.flight.fromIata} do ${widget.flight.toIata}'),

        ),
      ),
    );
  }
}
