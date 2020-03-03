import 'package:flutter/material.dart';
import 'Views/Home/Home.dart';
import 'Views/Signup/Signup.dart';
import 'Views/Login/Login.dart';
import 'Views/Root.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Fi-lo",
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{'/home': (context) => Home()},
    );
  }
}