import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_point.dart';
import 'package:weather/utils/string_extension.dart';

final class HourlyScreenArgs{
  final List<WeatherPoint> data;

  HourlyScreenArgs({required this.data});
}

class HourlyScreen extends StatelessWidget {
  static const routeName = '/hourly';

  final HourlyScreenArgs args;

  const HourlyScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Next 24 Hours',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: args.data.length,
          itemBuilder: (context, i) => _weatherInfo(context, args.data[i]),
        ),
      ),
    );
  }

  Widget _weatherInfo(BuildContext context, WeatherPoint weather) {
    final time = weather.date ?? DateTime.now();
    final hours = DateFormat.Hm().format(time);
    return Card(
      key: ValueKey(weather),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              hours,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              '${weather.dailyTemp?.toStringAsFixed(1)}°',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16.0),
            Icon(
              weather.condition.toWeatherIcon(),
              size: 25,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
