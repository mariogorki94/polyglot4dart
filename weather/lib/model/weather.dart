final class Weather {
  final double temp;
  final double tempMax;
  final double tempMin;
  final double lat;
  final double long;
  final double feelsLike;
  final int pressure;
  final String description;
  final String currently;
  final int humidity;
  final double windSpeed;
  final String cityName;

  Weather({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.lat,
    required this.long,
    required this.feelsLike,
    required this.pressure,
    required this.description,
    required this.currently,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
  });


  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      temp: (map['main']['temp']).toDouble(),
      tempMax: (map['main']['temp_max']).toDouble(),
      tempMin: (map['main']['temp_min']).toDouble(),
      lat: map['coord']['lat'],
      long: map['coord']['lon'],
      feelsLike: (map['main']['feels_like']).toDouble(),
      pressure: map['main']['pressure'],
      description: map['weather'][0]['description'],
      currently: map['weather'][0]['main'],
      humidity: map['main']['humidity'],
      windSpeed: (map['wind']['speed']).toDouble(),
      cityName: map['name'],
    );
  }
}