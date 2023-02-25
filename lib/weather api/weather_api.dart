import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/weather_repos/weather_model.dart';

Future<Weather?> fetchWeather({required String city}) async {
  Weather data;
  const apiKey = '99aab07a7bd4400983995903231802';
  final url = 'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // here convert object to json string
    final bodyAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    log(response.body);

     data = Weather.fromJson(bodyAsJson);
    
    return data;
  } else {
  
     throw Exception('Failed to fetch weather data');
    
  }
  
  
  
}
