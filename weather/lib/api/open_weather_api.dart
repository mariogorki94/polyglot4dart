import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/model/weather.dart';

import '../model/forecast.dart';

/// Must be top-level function
Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class OpenWeatherApi {
  static const _key = '4a2647402250754df53a94ad08c26a29';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/';

  final Dio _client;

  OpenWeatherApi()
      : _client = Dio(BaseOptions(
          baseUrl: _baseUrl,
          queryParameters: {
            'appid': _key,
            "units": 'metric',
          },
        )) {
    _client.transformer = BackgroundTransformer()
      ..jsonDecodeCallback = parseJson;
    _client.interceptors.add(LogInterceptor());
  }

  Future<Weather> getWeatherForLocation(String location) async {
    final response = await _client.get('weather', queryParameters: {
      'q': location,
    });

    return Weather.fromMap(response.data as Map<String, dynamic>);
  }

  Future<Weather> getWeatherForCoordinates(LatLng location) async {
    final response = await _client.get('weather', queryParameters: {
      'lat': location.latitude,
      'lon': location.longitude,
    });

    return Weather.fromMap(response.data as Map<String, dynamic>);
  }

  Future<Forecast> getForecast(LatLng location) async {
    final response = await _client.get('forecast', queryParameters: {
      'lat': location.latitude,
      'lon': location.longitude,
    });

    return Forecast.fromMap(response.data as Map<String, dynamic>);
  }
}
