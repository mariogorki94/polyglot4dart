import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/api/open_weather_api.dart';
import 'package:weather/model/weather_point.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/provider/location_provider.dart';
import 'package:weather/provider/weather_provider.dart';
import 'package:weather/screens/hourly_screen.dart';
import 'package:weather/widgets/city_bar.dart';
import 'package:weather/widgets/fade_animation.dart';
import 'package:weather/widgets/hourly_forecast.dart';
import 'package:weather/widgets/main_weather.dart';
import 'package:weather/widgets/provider_listener.dart';
import 'package:weather/widgets/request_error.dart';
import 'package:weather/widgets/weather_info.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => LocationProvider()..getCurrentLocation()),
        ChangeNotifierProvider(
            create: (_) => WeatherProvider(api: OpenWeatherApi()))
      ],
      child: ProviderListener<LocationProvider>(
        conditionCheck: (location) => location.lastLocation != null,
        listener: (context, location) {
          context
              .read<WeatherProvider>()
              .getWeatherForCoordinates(location.lastLocation!);
        },
        child: Scaffold(
          body: SafeArea(
            child: Consumer2<LocationProvider, WeatherProvider>(
                builder: (context, location, weather, _) {
              if (location.isLoading || weather.isLoading) {
                return const _Loading();
              }

              if (location.hasServiceError) {
                return RequestError(
                  icon: Icons.location_off,
                  title: "Your Location is disabled",
                  text: "Please turn your location services and refresh",
                  onRefresh: () =>
                      context.read<LocationProvider>().getCurrentLocation(),
                );
              }

              if (location.hasPermissionError) {
                return RequestError(
                  icon: Icons.location_disabled,
                  title: "We need location permissions",
                  text: "Please allow to use location and refresh",
                  onRefresh: () =>
                      context.read<LocationProvider>().getCurrentLocation(),
                );
              }

              return const _Content();
            }),
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CityBar(
          enabled: context
              .select<WeatherProvider, bool>((value) => !value.isLoading),
          callback: context.read<WeatherProvider>().getWeatherForLocation,
        ),
        Selector<WeatherProvider, bool>(
          selector: (_, provider) => provider.hasError,
          builder: (context, hasError, _) => hasError
              ? Expanded(
                  child: RequestError(
                    icon: Icons.wrong_location_outlined,
                    title: "No Search Results",
                    text:
                        "Please make sure you entered the correct location or check your device internet connectio",
                    onRefresh: () => context.read<WeatherProvider>().refresh(),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: context.read<WeatherProvider>().refresh,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      children: [
                        FadeAnimation(
                            duration: const Duration(milliseconds: 250),
                            child: Selector<WeatherProvider, Weather?>(
                              selector: (_, provider) => provider.weather,
                              builder: (context, weather, _) => weather == null
                                  ? const SizedBox.shrink()
                                  : MainWeather(weather: weather),
                            )),
                        FadeAnimation(
                            duration: const Duration(milliseconds: 500),
                            child: Selector<WeatherProvider, WeatherPoint?>(
                              selector: (_, provider) =>
                                  provider.forecast?.data.firstOrNull,
                              builder: (context, weather, _) => weather == null
                                  ? const SizedBox.shrink()
                                  : WeatherInfo(data: weather),
                            )),
                        FadeAnimation(
                          duration: const Duration(milliseconds: 750),
                          child: Selector<WeatherProvider, List<WeatherPoint>?>(
                            selector: (_, provider) => provider.forecast?.data,
                            builder: (context, weather, _) => weather == null
                                ? const SizedBox.shrink()
                                : HourlyForecast(
                                    data: weather.take(3).toList(),
                                    onSeeMoreClick: () {
                                      Navigator.of(context).pushNamed(
                                        HourlyScreen.routeName,
                                        arguments:
                                            HourlyScreenArgs(data: weather),
                                      );
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
