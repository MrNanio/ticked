import 'package:flutter/material.dart';

class TicketsWidget extends StatefulWidget {
  const TicketsWidget({Key? key}) : super(key: key);

  @override
  _TicketsWidgetState createState() => _TicketsWidgetState();
}

class _TicketsWidgetState extends State<TicketsWidget> {
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
            color: Colors.blueGrey,
            child: const SizedBox(
              width: double.infinity,
              height: 200,
              child: Center(child: Text('dodaj bilety na lot')),
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
}
