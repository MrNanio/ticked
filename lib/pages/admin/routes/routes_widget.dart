import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:ticked/utils/loading.dart';

class RoutesWidget extends StatefulWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  _RoutesWidgetState createState() => _RoutesWidgetState();
}

class _RoutesWidgetState extends State<RoutesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.grey[400],
            child: SizedBox(
              width: double.infinity,
              height: 400,
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
                                onChanged: (val) => setState(() {}),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              DropdownButtonFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Miasto przylotu'),
                                items: snapshot.data!.map((airport) {
                                  return DropdownMenuItem(
                                    value: airport.city,
                                    child: Text(airport.city),
                                  );
                                }).toList(),
                                onChanged: (val) => setState(() {}),
                              ),
                              /*TextFormField(
                              decoration:
                                  textInputDecoration.copyWith(hintText: 'Miasto przylotu'),
                            ),*/
                              const SizedBox(
                                height: 20.0,
                              ),
                              MaterialButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Wyszukaj połącznie',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)))
                            ],
                          ));
                        } else {
                          return Loading();
                        }
                      }),
                  const Divider(),
                ],
              ),
            )),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.blue,
            child: const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: Text('lista dodanych tras')),
            )),
      ],
    );
  }
}
