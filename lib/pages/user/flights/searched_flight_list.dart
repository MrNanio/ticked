import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/pages/user/flights/flight_tile.dart';
import 'package:ticked/services/flight_service.dart';

class SearchedFlightList extends StatefulWidget {
  const SearchedFlightList({
    Key? key,
  }) : super(key: key);

  @override
  _SearchedFlightListState createState() => _SearchedFlightListState();
}

class _SearchedFlightListState extends State<SearchedFlightList> {
  final flightService = FlightService();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    String fromIata = arguments['fromIata'];
    String toIata = arguments['toIata'];
    String date = arguments['date'];

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
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
              child: Text(
                "Wyszukane loty",
                style: TextStyle(fontSize: 20),
              )),
          SingleChildScrollView(
            child: StreamBuilder<List<Flight>>(
              stream: flightService.getFlightListByIataCodesAndDate(
                  fromIata, toIata, date),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var flights = snapshot.data;
                  if (flights!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 200,),
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.blue,
                              child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Center(child: Text('Nie znaleziono lotów\ndanego dnia ($date)',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ))
                                ),
                              )),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: flights.length,
                      itemBuilder: (context, index) {
                        return FlightTile(
                          flight: flights[index],
                        );
                      });
                }
                return const Center(
                  child: Text('Błąd'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
