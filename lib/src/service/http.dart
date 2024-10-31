import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Http {
  static String url = "http://192.168.1.108:5002/v1/";

  static Future postReporting(Map pdata) async {
    try {
      // Récupération du token
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("authToken");

      final res = await http.post(
        Uri.parse("${url}reporting/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(pdata),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print("Échec de l'ajout de reporting : ${res.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erreur : ${e.toString()}");
      }
    }
  }

  static Future postPharmacy(Map pdata) async {
    try {
      // Récupération du token
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("authToken");

      final res = await http.post(
        Uri.parse("${url}customer/"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(pdata),
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        if (kDebugMode) {
          print(data);
        }
      } else {
        if (kDebugMode) {
          print("Échec de l'ajout de la pharmacie : ${res.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erreur : ${e.toString()}");
      }
    }
  }

  static Future<bool> login(Map<String, String> pdata) async {
    try {
      if (kDebugMode) {
        print("Données envoyées dans le post : $pdata");
      }

      final response = await http.post(
        Uri.parse("${url}auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(pdata),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey("token")) {
          String token = data["token"];

          // Stockage du token avec SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("authToken", token);

          if (kDebugMode) {
            print("Token reçu : $token");
          }
          return true;
        } else {
          if (kDebugMode) {
            print("Le token est manquant dans la réponse.");
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print("Échec de connexion : ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erreur lors de la connexion : ${e.toString()}");
      }
      return false;
    }
  }
}
