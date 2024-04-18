# Flutter Weather App

This README provides an overview of the Flutter Weather App, a simple yet functional application designed to fetch and display weather information based on the user's current location. The app leverages several Flutter packages to achieve its functionality, including Dio for network requests, Location for obtaining the user's current location, LatLong2 for handling geographical coordinates, Material Design Icons for UI elements, Simple Animations for adding animations and Provider for state management.

## Features

- **Location-based Weather Information**: The app uses the `location` package to fetch the user's current location and then uses the `latlong2` package to convert this location into geographical coordinates.
- **Weather Data Fetching**: Utilizes the `dio` package to make network requests to a weather API, fetching weather data based on the user's location.
- **UI Components**: Employs Material Design Icons from the `material_design_icons_flutter` package to enhance the app's visual appeal.
- **Animations**: Incorporates animations into the app using the `simple_animations` package, enhancing the user experience with smooth transitions and effects.
- **State Management**: Manages the app's state efficiently using the `provider` package, ensuring a clean and maintainable codebase.

## Getting Started

To run this project, you'll need to have Flutter installed on your machine. Follow these steps to get the app up and running:

1. **Install Dependencies**: Navigate to the project directory and run `flutter pub get` to install all the necessary dependencies listed in the `pubspec.yaml` file.
2. **Run the App**: Execute `flutter run` to start the app on your preferred emulator or physical device.

## Dependencies

The app relies on the following packages:

- `dio: ^5.4.2+1` for network requests.
- `location: ^6.0.1` for obtaining the user's current location.
- `latlong2: ^0.9.1` for handling geographical coordinates.
- `material_design_icons_flutter: ^7.0.7296` for UI icons.
- `simple_animations: ^5.0.2` for adding animations.
- `intl: ^0.19.0` for internationalization support.
- `provider: ^6.1.2` for state management.
