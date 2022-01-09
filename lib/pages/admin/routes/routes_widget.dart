import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/models/route.dart' as model;
import 'package:ticked/pages/admin/routes/routes_tile_view.dart';
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
              "TRASY",
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
                                      value: airport.iataCode,
                                      child: Text(airport.city +
                                          '/' +
                                          airport.iataCode +
                                          ', ' +
                                          airport.country),
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
                                      value: airport.iataCode,
                                      child: Text(airport.city +
                                          '/' +
                                          airport.iataCode +
                                          ', ' +
                                          airport.country),
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
              child: Column(
                children: [
                  StreamBuilder<List<model.Route>>(
                    stream: routeService.getRoutes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var routes = snapshot.data;

                        return ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(4),
                            itemCount: routes!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                  child: RouteTile(
                                route: routes[index],
                              ));
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
