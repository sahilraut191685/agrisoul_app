import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// --- DATA MODELS ---
class WeatherData {
  final String locationName;
  final double temperature;
  final String condition;
  final String iconCode;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final List<HourlyForecast> hourlyForecast;

  WeatherData({
    required this.locationName,
    required this.temperature,
    required this.condition,
    required this.iconCode,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> currentData, Map<String, dynamic> forecastData) {
    List<HourlyForecast> hourly = [];
    if (forecastData['list'] != null) {
      for (int i = 0; i < 8; i++) { // Get the next 24 hours (8 * 3-hour intervals)
        hourly.add(HourlyForecast.fromJson(forecastData['list'][i]));
      }
    }

    return WeatherData(
      locationName: currentData['name'],
      temperature: (currentData['main']['temp'] as num).toDouble(),
      condition: currentData['weather'][0]['main'],
      iconCode: currentData['weather'][0]['icon'],
      feelsLike: (currentData['main']['feels_like'] as num).toDouble(),
      humidity: currentData['main']['humidity'],
      windSpeed: (currentData['wind']['speed'] as num).toDouble() * 3.6, // m/s to km/h
      hourlyForecast: hourly,
    );
  }
}

class HourlyForecast {
  final String time;
  final String iconCode;
  final double temperature;

  HourlyForecast({required this.time, required this.iconCode, required this.temperature});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateFormat('h a').format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      iconCode: json['weather'][0]['icon'],
      temperature: (json['main']['temp'] as num).toDouble(),
    );
  }
}

// --- WEATHER SERVICE ---
class WeatherService {
  final String apiKey;
  static const String _baseUrl = "https://api.openweathermap.org/data/2.5";

  WeatherService({required this.apiKey});

  Future<WeatherData> fetchWeather(String city) async {
    final weatherResponse = await http.get(Uri.parse('$_baseUrl/weather?q=$city&appid=$apiKey&units=metric'));
    final forecastResponse = await http.get(Uri.parse('$_baseUrl/forecast?q=$city&appid=$apiKey&units=metric'));

    if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      return WeatherData.fromJson(json.decode(weatherResponse.body), json.decode(forecastResponse.body));
    } else {
      throw Exception('Failed to load weather data for $city. Status Code: ${weatherResponse.statusCode}');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
       // If permission is still denied, return a default city.
       // The user will see an error in the UI if we can't get a location.
       return "Pune"; 
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    
    return placemarks[0].locality ?? "Pune"; // Use locality (city) or a default
  }
}

// --- UI WIDGETS ---
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // =======================================================================
  // === STEP 3: PASTE YOUR API KEY HERE ===================================
  // =======================================================================
  final WeatherService _weatherService = WeatherService(apiKey: "232d1637e3760d72a250090fa44621e9");
  WeatherData? _weatherData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWeatherForCurrentUserLocation();
  }

  Future<void> _fetchWeatherForCurrentUserLocation() async {
    try {
      String city = await _weatherService.getCurrentCity();
      _fetchWeather(city);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Could not fetch location. Please check permissions and internet connection.";
      });
    }
  }
  
  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await _weatherService.fetchWeather(city);
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Could not fetch weather for '$city'. Check your API key and internet connection.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: _buildWeatherUI(),
        ),
      ),
    );
  }

  Widget _buildWeatherUI() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      );
    }
    if (_weatherData != null) {
      return WeatherDisplay(weather: _weatherData!);
    }
    return const Center(
      child: Text("Ready to fetch weather data.", style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }
}


class WeatherDisplay extends StatelessWidget {
  final WeatherData weather;

  const WeatherDisplay({super.key, required this.weather});
  
  String _getWeatherIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@4x.png";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(weather.locationName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(DateFormat('EEEE, MMMM d').format(DateTime.now()), style: const TextStyle(fontSize: 16, color: Colors.white70)),
          const Spacer(),
          Image.network(_getWeatherIconUrl(weather.iconCode), width: 150, height: 150),
          Text('${weather.temperature.toStringAsFixed(0)}°C', style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w200, color: Colors.white)),
          Text(weather.condition, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white)),
          const Spacer(),
          const Text("Hourly Forecast", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.hourlyForecast.length,
              itemBuilder: (context, index) {
                final forecast = weather.hourlyForecast[index];
                return HourlyForecastCard(forecast: forecast);
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoTile(icon: Icons.thermostat, label: "Feels Like", value: "${weather.feelsLike.toStringAsFixed(0)}°C"),
              InfoTile(icon: Icons.water_drop, label: "Humidity", value: "${weather.humidity}%"),
              InfoTile(icon: Icons.air, label: "Wind Speed", value: "${weather.windSpeed.toStringAsFixed(1)} km/h"),
            ],
          ),
        ],
      ),
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  final HourlyForecast forecast;
  const HourlyForecastCard({super.key, required this.forecast});
  
  String _getWeatherIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@2x.png";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(forecast.time, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
          Image.network(_getWeatherIconUrl(forecast.iconCode), width: 40, height: 40),
          Text('${forecast.temperature.toStringAsFixed(0)}°', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const InfoTile({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}

