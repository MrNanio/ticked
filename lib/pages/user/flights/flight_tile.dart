import 'package:flutter/material.dart';
import 'package:ticked/models/flight.dart';

class FlightTile extends StatefulWidget {
  //const FlightTile({Key? key}) : super(key: key);
  static const routeName = '/extractArgumen';

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
          leading: const Icon(
            Icons.airplanemode_on_rounded,
            color: Colors.indigo,
            size: 36.0,
          ),
          title: Text(
              'Data lotu: ${widget.flight.date}, godzina: ${widget.flight.time}'),
          subtitle:
              Text('Z: ${widget.flight.fromCity}, ${widget.flight.fromCountry} '
                  '(${widget.flight.fromIata}) \nDo: ${widget.flight.toCity}, '
                  '${widget.flight.toCountry} (${widget.flight.toIata})'),
          onTap: (){
            Navigator.pushNamed(
                context,
                FlightTile.routeName,
                arguments: {
                  'flightCode': widget.flight.flightCode,
                }
            );
          },
        ),
      ),
    );
  }
}
