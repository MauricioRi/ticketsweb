import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';
//import 'package:movert_taxista/src/library/globals.dart' as _globals;

class SubRutasProvider {
  BaseUrl _url = BaseUrl();

  Future<Map<String, dynamic>> getSubroute(
      {@required String idSubroute}) async {
    try {
      Uri url = Uri.http(
          _url.getBaseUrl(),
          _url.getNextUrl() +
              "/getAllSubroutes/$idSubroute"); //del archivo routes
      print(url);
      final response = await http.post(url).timeout(
            Duration(seconds: 5),
          );
      if (response != null &&
          response?.statusCode != null &&
          response.statusCode == 200) {
        print(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey("data")) {
          return jsonResponse;
        } else {
          return {
            "status": false,
            "message": "Error al obtener la información"
          };
        }
      } else {
        return {"status": false, "mensaje": "Error al obtener la información"};
      }
    } catch (e) {
      return {"status": false, "mensaje": "Error al obtener la información"};
    }
  }

  Future<dynamic> createSubRoute({@required String idRoute, data}) async {
    try {
      Uri url = Uri.http(_url.getBaseUrl(),
          _url.getNextUrl() + "/newSubRoute/$idRoute"); //del archivo routes
      print(url);
      final response = await http.post(
        url,
        body: {"subroutes": data},
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
      ).timeout(
        Duration(seconds: 5),
      );
      if (response != null &&
          response?.statusCode != null &&
          response.statusCode == 201) {
        print(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        return jsonResponse;
      } else {
        return {"status": false, "mensaje": "Error al obtener la información"};
      }
    } catch (e) {
      return {"status": false, "mensaje": "Error al obtener la información"};
    }
  }
}
