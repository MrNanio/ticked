import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
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
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Column(
                children: [
                  StreamBuilder<List<Airport>>(
                      stream: AirportService().airports,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Form(
                              child: Column(
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text("Z "),

                              // TextFormField(
                              //   decoration:
                              //       textInputDecoration.copyWith(hintText: 'Miasto odlotu'),
                              // ),
                              DropdownButtonFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Miasto odlotu'),
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
                              Text("do "),
                              DropdownButtonFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Miasto przylotu'),
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
                              MaterialButton(
                                  onPressed: () async {
                                    await routeService.addRoute(fromIata, toIata);
                                  },
                                  child: const Text(
                                    'Dodaj',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40))),

                            ],
                          ));
                        } else {
                          return Loading();
                        }
                      }),
                ],
              ),
            )),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.blue,
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: Column(
                children: [


                ],
              ),
            )),
      ],
    );
  }
}
