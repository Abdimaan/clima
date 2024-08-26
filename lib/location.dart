import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;

  Location({this.latitude = 0.0, this.longitude = 0.0});

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Error getting location: $e');
      // Handle location-related exceptions here
    }
  }
}
