import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/home_test_page.dart';
import 'package:flutter_assignment/pages/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeTestPage(),  //  Search(),//
    );
  }
}

