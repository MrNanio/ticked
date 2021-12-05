import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/services/route_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:ticked/utils/loading.dart';

class RoutesWidget extends StatefulWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  _RoutesWidgetState createState() => _RoutesWidgetState();
}

class _RoutesWidgetState extends State<RoutesWidget> {
  final RouteService routeService = RouteService();
  String fromIata = "";
  String toIata = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Text(
              "Trasa lotu",
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
                  StreamBuilder<List<Airport>>(
                      stream: AirportService().airports,
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
                                    "Punkt startowy",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ]),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Początek trasy'),
                                  items: snapshot.data!.map((airport) {
                                    return DropdownMenuItem(
                                      value: airport.city,
                                      child: Text(airport.city),
                                    );
                                  }).toList(),
                                  onChanged: (val) => setState(() {
                                    fromIata = val.toString();
                                  }),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Row(children: const [
                                  Icon(Icons.airplanemode_active),
                                  Text(
                                    "Punkt końcowy",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ]),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Koniec trasy'),
                                  items: snapshot.data!.map((airport) {
                                    return DropdownMenuItem(
                                      value: airport.city,
                                      child: Text(airport.city),
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
                                        await routeService.addRoute(
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
              height: 300,
              child: Column(
                children: [
                  StreamBuilder<List<Flight>>(
                    stream: routeService.getFlights(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var flights = snapshot.data;

                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: flights!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 50,
                                color: Colors.white,
                                child: Center(
                                    child: Text(' ${flights[index].toIata}')),
                              );
                            });
                      }
                      return const Text('jestem debilem i nic nie widzę');
                    },
                  )
                ],
              ),
            )),
      ],
    );
  }
}
