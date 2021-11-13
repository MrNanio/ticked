import 'package:flutter/material.dart';
import 'package:ticked/utils/form_decorators.dart';
import 'package:intl/intl.dart';

class SearchFlight extends StatefulWidget {
  const SearchFlight({Key? key}) : super(key: key);

  @override
  _SearchFlightState createState() => _SearchFlightState();
}

class _SearchFlightState extends State<SearchFlight> {

  TextEditingController _dateEditingController = TextEditingController();
  String _start = '';
  String _end = '';
  DateTime? _selectedDate;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Miasto odlotu'),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Miasto przylotu'),

                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Data podróży'),
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: _dateEditingController,
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    MaterialButton(
                        onPressed: () {},
                        child: Text('Wyszukaj bilet',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))
                    )
                  ],
                )
            ),
            Divider(),
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
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo
              )
            ),
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
