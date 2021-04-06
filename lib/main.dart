import 'package:flutter/material.dart';
import 'package:smart_study/Pages/Home.dart';
import 'package:smart_study/Pages/Loading.dart';
import 'package:smart_study/Pages/SignIn.dart';
import 'package:smart_study/Pages/SignUp.dart';
import 'package:smart_study/Pages/Welcome.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Georgia'
    ),
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


