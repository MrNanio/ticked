import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
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

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _routeCodeController = TextEditingController();
  final TextEditingController _datePickController = TextEditingController();
  final TextEditingController _timePickController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  int _currentCapacityIntValue = 0;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

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
              height: 700,
              child: Column(
                children: [
                  StreamBuilder<List<model.Route>>(
                      stream: routeService.getRoutes(),
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
                                          child: Text(route.fromCity +
                                              "/" +
                                              route.fromIata +
                                              " -> " +
                                              route.toCity +
                                              "/" +
                                              route.toIata),
                                        );
                                      }).toList(),
                                      validator: (val) =>
                                          val == null ? 'Wybierz trasę' : null,
                                      onChanged: (val) => setState(() {
                                        _routeCodeController.text =
                                            val.toString();
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
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Data lotu'),
                                      focusNode: AlwaysDisabledFocusNode(),
                                      controller: _datePickController,
                                      validator: (val) => val!.isEmpty
                                          ? 'Wybierz datę lotu'
                                          : null,
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Godzina lotu",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Godzina lotu'),
                                      focusNode: AlwaysDisabledFocusNode(),
                                      controller: _timePickController,
                                      validator: (val) => val!.isEmpty
                                          ? 'Wybierz godzinę lotu'
                                          : null,
                                      onTap: () {
                                        _pickTime(context);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(children: const [
                                      Icon(Icons.airplanemode_active),
                                      Text(
                                        "Liczba miejsc",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ]),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    NumberPicker(
                                      value: _currentCapacityIntValue,
                                      minValue: 0,
                                      maxValue: 250,
                                      step: 1,
                                      itemHeight: 50,
                                      axis: Axis.horizontal,
                                      onChanged: (val) => setState(() {
                                        _currentCapacityIntValue = val;
                                        _capacityController.text =
                                            val.toString();
                                      }),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border:
                                            Border.all(color: Colors.black26),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Center(
                                      child: MaterialButton(
                                          height: 50.0,
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await flightService.addFlight(
                                                  _routeCodeController.text,
                                                  _datePickController.text,
                                                  _timePickController.text,
                                                  _capacityController.text);
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

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        locale: const Locale('pl', 'PL'),
        initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.indigo)),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _datePickController
        ..text = DateFormat('dd/MM/yyyy').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _datePickController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _pickTime(BuildContext context) async {
    final TimeOfDay initialTime = TimeOfDay(hour: 9, minute: 0);
    final TimeOfDay? newTime = await showTimePicker(
        context: context, initialTime: _selectedTime ?? initialTime);

    if (newTime != null) {
      _selectedTime = newTime;
      final hours = newTime.hour.toString().padLeft(2, '0');
      final minutes = newTime.minute.toString().padLeft(2, '0');
      _timePickController
        ..text = '$hours:$minutes'
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _timePickController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  void resetForm() {
    _currentCapacityIntValue = 0;
    _selectedDate = null;
    _selectedTime = null;
    _routeCodeController.clear();
    _datePickController.clear();
    _timePickController.clear();
    _capacityController.clear();
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
