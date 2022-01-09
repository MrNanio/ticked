import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/services/flight_service.dart';
import 'package:ticked/services/route_service.dart';
import 'package:ticked/services/ticket_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:ticked/utils/loading.dart';

class TicketsWidget extends StatefulWidget {
  const TicketsWidget({Key? key}) : super(key: key);

  @override
  _TicketsWidgetState createState() => _TicketsWidgetState();
}

class _TicketsWidgetState extends State<TicketsWidget> {

  final AirportService airportService = AirportService();
  final RouteService routeService = RouteService();
  final FlightService flightService = FlightService();
  final TicketService ticketService = TicketService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _flightCodeController = TextEditingController();
  final TextEditingController _classA = TextEditingController();
  final TextEditingController _classB = TextEditingController();
  final TextEditingController _classC = TextEditingController();
  int _numbersTicketClassA=0;
  int _numbersTicketClassB=0;
  int _numbersTicketClassC=0;
  int _currentCapacityIntValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
            child: Text(
              "BILETY",
              style: TextStyle(fontSize: 20),
            )),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 600,
              child: Column(
                children: [
                  StreamBuilder<List<Flight>>(
                      stream: flightService.getAllFlights(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Form(
                              key: _formKey,
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
                                        "Lot",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    DropdownButtonFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'wybierz lot'),
                                      items: snapshot.data!.map((flight) {
                                        return DropdownMenuItem(
                                          value: flight.flightCode,
                                          child: Text(
                                              flight.fromIata +
                                              " -> " +
                                              flight.toIata+' | '+flight.date +' | '+flight.time

                                          ),
                                        );
                                      }).toList(),
                                      validator: (val) =>
                                      val == null ? 'Wybierz trasę' : null,
                                      onChanged: (val) => setState(() {
                                        _flightCodeController.text =
                                            val.toString();
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),

                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Liczba biletów klasy A",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    NumberPicker(
                                      value: _numbersTicketClassA,
                                      minValue: 0,
                                      maxValue: 250,
                                      step: 1,
                                      itemHeight: 50,
                                      axis: Axis.horizontal,
                                      onChanged: (val) => setState(() {
                                        _numbersTicketClassA = val;
                                        _classA.text =
                                            val.toString();
                                      }),
                                    ),
                                    /*TextFormField(
                                decoration:
                                    textInputDecoration.copyWith(hintText: 'Miasto przylotu'),
                            ),*/
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Liczba biletów klasy B",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    NumberPicker(
                                      value: _numbersTicketClassB,
                                      minValue: 0,
                                      maxValue: 250,
                                      step: 1,
                                      itemHeight: 50,
                                      axis: Axis.horizontal,
                                      onChanged: (val) => setState(() {
                                        _numbersTicketClassB = val;
                                        _classB.text =
                                            val.toString();
                                      }),
                                    ),
                                    /*TextFormField(
                                decoration:
                                    textInputDecoration.copyWith(hintText: 'Miasto przylotu'),
                            ),*/
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Liczba biletów klasy C",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    NumberPicker(
                                      value: _numbersTicketClassC,
                                      minValue: 0,
                                      maxValue: 250,
                                      step: 1,
                                      itemHeight: 50,
                                      axis: Axis.horizontal,
                                      onChanged: (val) => setState(() {
                                        _numbersTicketClassC = val;
                                        _classC.text =
                                            val.toString();
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
                                          height: 50.0,
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await ticketService.addTickets(
                                                  _flightCodeController.text,
                                                  _numbersTicketClassA,
                                                  _numbersTicketClassB,
                                                  _numbersTicketClassC);
                                            }
                                            setState(() {
                                              resetForm();
                                            });
                                          },
                                          child: const Text(
                                            'Dodaj',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.indigo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
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
            color: Colors.blue,
            child: const SizedBox(
              width: double.infinity,
              height: 300,
              child: Center(child: Text('lista dodanych biletów')),
            )),
      ],
    );
  }

  void resetForm() {
    _currentCapacityIntValue = 0;
    _numbersTicketClassA = 0;
    _numbersTicketClassB = 0;
    _numbersTicketClassC = 0;
    _flightCodeController.clear();
    _classA.clear();
    _classB.clear();
    _classC.clear();
  }
}
