import 'weather_point.dart';

final class Forecast {
  final List<WeatherPoint> data;

  const Forecast({
    required this.data,
  });

  factory Forecast.fromMap(Map<String, dynamic> json) {

    List items = json['list'];

    return Forecast(
      data: items.map(WeatherPoint.fromMap).toList(),
    );
  }
}
