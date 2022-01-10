import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/services/flight_service.dart';

class TicketBookWidget extends StatefulWidget {
  const TicketBookWidget({Key? key}) : super(key: key);

  @override
  _TicketBookWidgetState createState() => _TicketBookWidgetState();
}

class _TicketBookWidgetState extends State<TicketBookWidget> {
  final flightService = FlightService();
  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String flightCode = arguments['flightCode'];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'TICKED',
            style: GoogleFonts.jetBrainsMono(
                textStyle: const TextStyle(color: Colors.white, fontSize: 30)),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: FutureBuilder<DocumentSnapshot>(
                  future: flightService.getFlight(flightCode),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(children: [
                        Text(
                          '${snapshot.data!['from_city']}, ${snapshot.data!['from_country']} -> ${snapshot.data!['to_city']}, ${snapshot.data!['to_country']} ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ).padding(bottom: 5),
                        Text(
                          '${snapshot.data!['date']} | ${snapshot.data!['time']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ).padding(bottom: 5),
                      ]);
                    }
                    return const LinearProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
