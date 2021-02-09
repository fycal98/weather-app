import 'package:http/http.dart' as http;

class Networking {
  String url;
  Networking({this.url});

  Future<dynamic> GetWeather() async {
    var weather = await http.get(url);
    return weather;
  }
}
