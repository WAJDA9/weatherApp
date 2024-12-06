import 'dart:convert';

import 'package:http/http.dart';
import 'package:weatherapp/models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String city) async {
    try {
      final response = await get(Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=ef5102bfd8104f07a7e21736240612&q=London'));
      print("object");
      if (response.statusCode != 200) {
        throw Exception('Failed to load weather');
      }
      return Weather.fromJson(json.decode(response.body));
    } on Exception catch (e) {
      throw Exception('Failed to load weather: ${e.toString()}');
    }
  }
}
