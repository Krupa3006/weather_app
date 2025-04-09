import 'dart:convert';
import "package:http/http.dart" as http;
import '../models/weather.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=London&appid=b1980f0d570a676bd673213f30d4137e',
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error getting weather');
    }
  }
}
