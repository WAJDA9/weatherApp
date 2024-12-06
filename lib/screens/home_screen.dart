import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/repository/weather_repository.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Weather weatherInfo = Weather();
  @override
  void initState() {
    getData();
    super.initState();
    // _playBackgroundSound();
  }

  void getData() async {
    
   try {
     weatherInfo = await WeatherRepository().fetchWeather('sousse');
   }
   on Exception catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('Failed to load weather:}'),
       ));
   }
  }

  void _playBackgroundSound() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/waves.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: DateTime.now().hour > 18
              ? [Colors.lightBlue[300]!, Colors.blue[900]!]
              : [Colors.indigo[700]!, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    "Ocean Weather",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Current Weather: ${weatherInfo.current!.condition!.text!}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Temperature: ${weatherInfo.current!.tempC}°C",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  // const ForecastChart(),
                  const Spacer(),
                ],
              ),
            ),
            Positioned(
              child: Lottie.asset(
                'assets/animations/sun_animation.json',
              ),
              top: 20,
              left: 50,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width, // Full width
                height: 500,
                child: Lottie.asset(
                  'assets/animations/animate2.json', // Replace with your own ocean waves animation
                  fit: BoxFit.cover,
                  repeat: true,
                  animate: true,
                  options: LottieOptions(enableMergePaths: true),
                  onLoaded: (composition) {
                    print(
                        'Animation Loaded. Duration: ${composition.duration}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
