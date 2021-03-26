import 'package:flutter/material.dart';
import 'package:smart_study/Pages/Home.dart';
import 'package:smart_study/Pages/Loading.dart';
import 'package:smart_study/Pages/SignIn.dart';
import 'package:smart_study/Pages/SignUp.dart';
import 'package:smart_study/Pages/Welcome.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/welcome': (context) => Welcome(),
      '/register': (context) => SignUp(),
      '/login': (context) => SignIn(),


    },
  ));
}


