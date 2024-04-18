import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  bool isLoading = false;
  LatLng? lastLocation;
  bool hasServiceError = false;
  bool hasPermissionError = false;

  Future<void> getCurrentLocation() async {
    isLoading = true;
    hasServiceError = false;
    hasPermissionError = false;
    notifyListeners();

    try{
      final location = Location.instance;

      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          hasServiceError = true;
          return;
        }
      }

      var permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) {
          hasPermissionError = true;
          return;
        }
      }

      final loc = await location.getLocation();
      lastLocation = LatLng(loc.latitude!, loc.longitude!);
    }catch(e){
      hasServiceError = true;
    }finally{
      isLoading = false;
      notifyListeners();
    }

  }
}
