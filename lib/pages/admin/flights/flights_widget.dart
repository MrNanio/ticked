import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/models/route.dart' as model;
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/services/flight_service.dart';
import 'package:ticked/services/route_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:ticked/utils/loading.dart';

import 'flights_tile_view.dart';

class FlightsWidget extends StatefulWidget {
  const FlightsWidget({Key? key}) : super(key: key);

  @override
  _FlightsWidgetState createState() => _FlightsWidgetState();
}

class _FlightsWidgetState extends State<FlightsWidget> {
  final AirportService airportService = AirportService();
  final RouteService routeService = RouteService();
  final FlightService flightService = FlightService();

  String fromIata = "";
  String toIata = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Text(
              "LOTY",
              style: TextStyle(fontSize: 20),
            )),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 350,
              child: Column(
                children: [
                  StreamBuilder<List<model.Route>>(
                      stream: routeService.getRoutes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Form(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Trasa",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    DropdownButtonFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Trasa'),
                                      items: snapshot.data!.map((route) {
                                        return DropdownMenuItem(
                                          value: route.routeCode,
                                          child: Text(route.fromCity + "/" +
                                              route.fromIata + " -> " +
                                              route.toCity + "/" + route.toIata),
                                        );
                                      }).toList(),
                                      onChanged: (val) =>
                                          setState(() {
                                            fromIata = val.toString();
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Data lotu",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    DropdownButtonFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Data lotu'),
                                      items: snapshot.data!.map((route) {
                                        return DropdownMenuItem(
                                          value: route.fromIata,
                                          child: Text(route.fromIata + route.toIata),
                                        );
                                      }).toList(),
                                      onChanged: (val) => setState(() {
                                        toIata = val.toString();
                                      }),
                                    ),
                                    /*TextFormField(
                                decoration:
                                    textInputDecoration.copyWith(hintText: 'Miasto przylotu'),
                            ),*/
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Center(
                                      child: MaterialButton(
                                          onPressed: () async {
                                            await flightService.addFlight(
                                                fromIata, toIata);
                                          },
                                          child: const Text(
                                            'Dodaj',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.indigo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(40))),
                                    ),
                                  ],
                                ),
                              ));
                        } else {
                          return const Loading();
                        }
                      }),
                ],
              ),
            )),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  StreamBuilder<List<Flight>>(
                    stream: flightService.getAllFlights(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var flights = snapshot.data;

                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(4),
                            itemCount: flights!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                  child: FlightsTile(flight: flights[index]));
                            });
                      }
                      return const Text('no data');
                    },
                  )
                ],
              ),
            )),
      ],
    );
  }
}
