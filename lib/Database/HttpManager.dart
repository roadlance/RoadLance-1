import 'package:http/http.dart' as http;

class HttpManager {
  Future<String> getNumberPlate(String url) async {
    url = url
        .replaceAll('https', 'secure')
        .replaceAll('/', 'slash')
        .replaceAll('.', 'dot')
        .replaceAll(':', 'colon')
        .replaceAll('-', 'dash')
        .replaceAll('&', 'ampersand');

    String baseUrl = 'http://127.0.0.1:5000/number-plate/';
    http.Response res = await http.get(baseUrl + url);
    return res.body;
  }
}
