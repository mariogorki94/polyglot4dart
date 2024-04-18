import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_point.dart';
import 'package:weather/utils/string_extension.dart';

class HourlyForecast extends StatelessWidget {
  final List<WeatherPoint> data;
  final VoidCallback onSeeMoreClick;

  const HourlyForecast(
      {super.key, required this.data, required this.onSeeMoreClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Next 3 Hours',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: onSeeMoreClick,
                child: const Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data
                .take(3)
                .map((item) => hourlyWidget(item, context))
                .toList()),
      ],
    );
  }

  Widget hourlyWidget(WeatherPoint weather, BuildContext context) {
    final hours = DateFormat.Hm().format(weather.date!);

    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  hours,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  weather.condition.toWeatherIcon(),
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    "${weather.dailyTemp?.toStringAsFixed(1)}°C",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
