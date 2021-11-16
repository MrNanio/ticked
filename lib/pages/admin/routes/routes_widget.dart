import 'package:flutter/material.dart';

class RoutesWidget extends StatefulWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  _RoutesWidgetState createState() => _RoutesWidgetState();
}

class _RoutesWidgetState extends State<RoutesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blueGrey,
              child: const SizedBox(
                width: double.infinity,
                height: 400,
                child: Center(child: Text('dodaj trasy')),
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
      ),
    );
  }
}
