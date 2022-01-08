import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:intl/intl.dart';
import 'package:ticked/utils/loading.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({Key? key}) : super(key: key);

  static const routeName = '/extractArguments';

  @override
  _SearchFlightState createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _datePickController = TextEditingController();
  final TextEditingController _startCityController = TextEditingController();
  final TextEditingController _endCityController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
      child: Column(
        children: [
          StreamBuilder<List<Airport>>(
              stream: AirportService().airports,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          DropdownButtonFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Miasto odlotu'),
                              items: snapshot.data!.map((airport) {
                                return DropdownMenuItem(
                                  value: airport.iataCode,
                                  child: Text(airport.city + "-"+ airport.iataCode),
                                );
                              }).toList(),
                            validator: (val) => val == null ? 'Wybierz miasto odlotu' : null,
                            onChanged: (val) => setState(() {
                                _startCityController.text = val.toString();
                            }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DropdownButtonFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Miasto przylotu'),
                              items: snapshot.data!.map((airport) {
                                return DropdownMenuItem(
                                  value: airport.iataCode,
                                  child: Text(airport.city + "-"+ airport.iataCode),
                                );
                              }).toList(),
                            validator: (val) => val == null ? 'Wybierz miasto przylotu' : null,
                            onChanged: (val) => setState(() {
                              _endCityController.text = val.toString();
                            }),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Data podróży'),
                            focusNode: AlwaysDisabledFocusNode(),
                            controller: _datePickController,
                            validator: (val) => val!.isEmpty ? 'Wybierz datę podróży': null,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          MaterialButton(
                              height: 50.0,
                              onPressed: () {
                                if(_formKey.currentState!.validate()) {
                                  print(_startCityController.text);
                                  print(_endCityController.text);
                                  print(_datePickController.text);
                                  Navigator.pushNamed(
                                      context,
                                      SearchFlight.routeName,
                                      arguments: {
                                          'fromIata': _startCityController.text,
                                          'toIata': _endCityController.text,
                                          'date': _datePickController.text
                                      }
                                   );
                                  /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SearchedFlightList(
                                              fromIata: _startCityController.text,
                                              toIata: _endCityController.text,
                                              date: _dateEditingController.text)
                                      )
                                  );*/
                                }
                              },
                              child: const Text(
                                'Wyszukaj połącznie',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))
                        ],
                  ));
                } else {
                  return Loading();
                }
              }),
        ],
      ),
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
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
