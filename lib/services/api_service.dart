import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.100.225:8000";

  static Future<Map> checkUrl(String url) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"url": url}),
    );

    return jsonDecode(response.body);
  }
}
