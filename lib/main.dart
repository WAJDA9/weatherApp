import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/screens/home_screen.dart';

void main() {
  runApp(const OceanWeatherApp());
}

class OceanWeatherApp extends StatelessWidget {
  const OceanWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.lightBlue[50],
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              color: Colors.blue[900],
              fontSize: 28,
              fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.blue[800], fontSize: 16),
        ),
      ),
      home: const WeatherHomePage(),
    );
  }
}
