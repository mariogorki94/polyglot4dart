import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/utils/string_extension.dart';

class MainWeather extends StatelessWidget {
  final Weather weather;

  const MainWeather({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined),
              Text(
                weather.cityName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Text(
            DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                weather.currently.toWeatherIcon(),
                size: 55,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 16.0),
              Text(
                '${weather.temp.toStringAsFixed(0)}°C',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            '${weather.tempMax.toStringAsFixed(0)}°/ ${weather.tempMin.toStringAsFixed(0)}° Feels like ${weather.feelsLike.toStringAsFixed(0)}°',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            toBeginningOfSentenceCase(weather.description) ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }
}
