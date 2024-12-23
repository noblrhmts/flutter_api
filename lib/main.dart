import 'package:flutter/material.dart';
import 'package:flutter_api/api_service.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController searchController = TextEditingController();

  List<String> cities = ['Banyuwangi', 'Surabaya', 'Jember', 'Malang', 'Jombang'];
  List<Map<String, dynamic>> weatherData = [];
  Map<String, dynamic>? searchedWeather;
  bool isLoading = true;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    try {
      final data = await apiService.fetchMultipleCitiesWeather(cities);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $error')),
      );
    }
  }

  void searchWeather() async {
    if (searchController.text.isEmpty) return;
    setState(() {
      isSearching = true;
    });

    try {
      final data = await apiService.fetchWeather(searchController.text);
      setState(() {
        searchedWeather = data;
        isSearching = false;
      });
    } catch (error) {
      setState(() {
        isSearching = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kota tidak ditemukan! Mohon coba lagi.')),
      );
    }
  }

  IconData getWeatherIcon(String condition) {
    return Icons.cloud;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cuaca Jawa Timur',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 42, 255),
        titleTextStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Cari Kota',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: searchWeather,
                  child: Text('Cari'),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (isSearching) ...[
              Center(child: CircularProgressIndicator()),
            ] else if (searchedWeather != null) ...[
              ListTile(
                leading: Icon(
                  getWeatherIcon(searchedWeather!['weather'][0]['description']),
                  size: 40,
                ),
                title: Text(
                  searchedWeather!['name'],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                    'Temp: ${searchedWeather!['main']['temp']}°C, ${searchedWeather!['weather'][0]['description']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(weather: searchedWeather!),
                    ),
                  );
                },
              ),
            ],
            SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: weatherData.length,
                      itemBuilder: (context, index) {
                        final cityWeather = weatherData[index];
                        final condition = cityWeather['weather'][0]['description'];
                        final icon = getWeatherIcon(condition);

                        return ListTile(
                          leading: Icon(icon, size: 40),
                          title: Text(
                            cityWeather['name'],
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Temp: ${cityWeather['main']['temp']}°C'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(weather: cityWeather),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> weather;

  DetailScreen({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${weather['name']} Detail Cuaca',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 42, 255),
        titleTextStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kota: ${weather['name']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Temperatur: ${weather['main']['temp']}°C'),
            Text('Kondisi: ${weather['weather'][0]['description']}'),
            Text('Kelembapan: ${weather['main']['humidity']}%'),
            Text('Kecepatan Angin: ${weather['wind']['speed']} m/s'),
          ],
        ),
      ),
    );
  }
}
