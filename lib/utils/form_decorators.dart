import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0))
);
