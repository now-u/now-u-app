import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {

  Position _currentPosition;
  String _currentAddress;

  getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition();
  }

  getCurrentAddress() async {
    _currentPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
    print(placemarks[0]);
    print(placemarks[0].postalCode);
  }

}
