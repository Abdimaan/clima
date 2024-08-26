import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final Uri url;

  NetworkHelper(String urlString) : url = Uri.parse(urlString);

  Future  getData() async {
    http.Response res = await http.get(url);
    if (res.statusCode == 200) {
      String data = res.body;
      return jsonDecode(data);
    } else {
      print(res.statusCode);
      
    }
  }
}