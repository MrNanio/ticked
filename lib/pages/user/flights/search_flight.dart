import 'package:flutter/material.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/services/airport_service.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:intl/intl.dart';
import 'package:ticked/utils/loading.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({Key? key}) : super(key: key);

  @override
  _SearchFlightState createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {
  final TextEditingController _dateEditingController = TextEditingController();
  final TextEditingController startCityController = TextEditingController();
  final TextEditingController endCityController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
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
                                }).toList()),
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
                                }).toList()),
                            /*TextFormField(
                              decoration:
                                  textInputDecoration.copyWith(hintText: 'Miasto przylotu'),
                            ),*/
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Data podróży'),
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: _dateEditingController,
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
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
      _dateEditingController
        ..text = DateFormat('dd/MM/yyyy').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
