import 'package:geolocator/geolocator.dart';

class Locator {
  Position getCurrentPosition() {
    Position currentPosition;
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      currentPosition = position;
    }).catchError((err) {
      print('An error occured while getting current location : $err');
    });
    return currentPosition;
  }
}
