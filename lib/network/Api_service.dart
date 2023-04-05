import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthenticationServices {
  static Future<dynamic> baseFunction(
      Uri url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(url, body: data);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('error occured while dealing with the api');
    }
  }
}
