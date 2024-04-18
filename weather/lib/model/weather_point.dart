final class WeatherPoint{
  final num? dailyTemp;
  final String? condition;
  final DateTime? date;
  final String? precip;
  final num? clouds;

  WeatherPoint({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.clouds,
  });

  factory WeatherPoint.fromMap(dynamic json) {
    return WeatherPoint(
      dailyTemp: json['main']['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      precip: (json['pop'] * 100).toStringAsFixed(0),
      clouds: json['clouds']['all']
    );
  }

}