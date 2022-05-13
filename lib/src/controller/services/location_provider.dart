import 'package:location/location.dart';

class LocationProvider {
  Location location = Location();
  late bool _isServiceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;

  Future<List<String>> getLocation() async {
    _isServiceEnabled = await location.serviceEnabled();
    if (!_isServiceEnabled) {
      _isServiceEnabled = await location.requestService();
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      // if (_permissionGranted != PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();

    var latitudeLongitude = [
      '${locationData.latitude}',
      '${locationData.longitude}'
    ];

    return latitudeLongitude;
  }
}
