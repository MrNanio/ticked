import 'package:flutter/material.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/models/route.dart' as model;

class RouteTile extends StatefulWidget {
  //const FlightTile({Key? key}) : super(key: key);

  RouteTile({required this.route});

  final model.Route route;

  @override
  _RouteTileState createState() => _RouteTileState();

}

class _RouteTileState extends State<RouteTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
          ),
          title: Text('Data lotu:  ${widget.route.airlineCode}'),
          subtitle: Text('Z ${widget.route.fromIata} do ${widget.route.toIata}'),

        ),
      ),
    );
  }
}