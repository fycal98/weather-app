import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> GetPosition() async {
    try {
      var position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      return position;
    } catch (e) {
      print('error to get position');
    }
  }
}
