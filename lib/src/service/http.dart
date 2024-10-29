import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Http {
  static String url = "http://192.168.1.9:5002/v1/auth/";

  static postProduct(Map pdata) async {
    try {
      final res = await http.post(Uri.parse("${url}login"), body: pdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print("Failed to load data");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
