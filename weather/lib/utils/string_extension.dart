import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

extension StringExtension on String? {
  IconData toWeatherIcon() {
    switch (this) {
      case 'Thunderstorm':
        return MdiIcons.weatherLightningRainy;
      case 'Drizzle':
        return MdiIcons.weatherPartlyRainy;
      case 'Rain':
        return MdiIcons.weatherRainy;
      case 'Snow':
        return MdiIcons.weatherSnowy;
      case 'Clear':
        return MdiIcons.weatherSunny;
      case 'Clouds':
        return MdiIcons.weatherCloudy;
      case 'Mist':
        return MdiIcons.weatherFog;
      case 'fog':
        return MdiIcons.weatherFog;
      case 'Smoke':
        return MdiIcons.smoke;
      case 'Haze':
        return MdiIcons.weatherHazy;
      case 'Dust':
      case 'Sand':
      case 'Ash':
        return MdiIcons.weatherDust;
      case 'Squall':
      case 'Tornado':
        return MdiIcons.weatherTornado;
      default:
        return MdiIcons.weatherCloudy;
    }
  }
}
