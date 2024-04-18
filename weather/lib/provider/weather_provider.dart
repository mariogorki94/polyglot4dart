import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/api/open_weather_api.dart';
import 'package:weather/model/forecast.dart';
import 'package:weather/model/weather.dart';

class WeatherProvider with ChangeNotifier {
  final OpenWeatherApi _api;


  bool isLoading = false;
  bool hasError = false;
  Weather? weather;
  Forecast? forecast;

  WeatherProvider({required OpenWeatherApi api}) : _api = api;

  Future<void> getWeatherForCoordinates(LatLng coords,{ bool isRefreshing = false}) async {
    isLoading = true;
    hasError = false;
    if (!isRefreshing) notifyListeners();

    try {
      weather = await _api.getWeatherForCoordinates(coords);
      forecast = await _api.getForecast(coords);
    } catch (e) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getWeatherForLocation(String location) async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      weather = await _api.getWeatherForLocation(location);
      forecast = await _api.getForecast(LatLng(weather!.lat, weather!.long));
    } catch (e) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    if (weather == null) return;

    await getWeatherForCoordinates(LatLng(weather!.lat, weather!.long), isRefreshing: true);
  }
}
