import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _apiKey = '0539bd7bbf20677afa6095f3a7c8d24d';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMultipleCitiesWeather(List<String> cities) async {
    List<Map<String, dynamic>> weatherList = [];
    for (String city in cities) {
      final weather = await fetchWeather(city);
      weatherList.add(weather);
    }
    return weatherList;
  }
}
