import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthenticationServices {
  static Future<dynamic> baseFunction(
      Uri url, Map<String, dynamic> data) async {
    try {
      final response = await http.post(url, body: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<dynamic> getBaseFunction(Uri url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      throw Exception('error occured while dealing with the api');
    }
  }
}
