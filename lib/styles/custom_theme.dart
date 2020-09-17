import 'package:flutter/material.dart';

ThemeData customTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Colors.indigo,
  ),
  textTheme: TextTheme(
    headline4: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
    headline5: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
  )
);