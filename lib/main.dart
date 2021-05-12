import 'package:flutter/material.dart';
import 'package:fire99/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
       debugShowCheckedModeBanner: false,
    );
  }
}
