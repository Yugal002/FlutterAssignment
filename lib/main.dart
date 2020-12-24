import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/home_Test_2_page.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(), //HomeTestPage(),  // HomeTestPage2(),
    );
  }
}


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin(){
    Future.delayed(const Duration(milliseconds: 2000), () {

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeTestPage(),
          ));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        // color: Color(0xffe1e3dd),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Wiki Search',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}