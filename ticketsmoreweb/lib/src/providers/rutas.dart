import 'package:http/http.dart' as _http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/Routes.model.dart';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';
import 'dart:convert';
//import 'package:movert_taxista/src/library/globals.dart' as _globals;

class RutasProvider {
  BaseUrl _url = BaseUrl();

  Future<Map<String, dynamic>> getRoute({@required String id_user}) async {
    Uri url = Uri.http(_url.getBaseUrl(),
        _url.getNextUrl() + "/getRoute"); //del archivo routes
    print(url);
    final response = await http
        .post(url, body: {"id_user": id_user})
        .timeout(
          Duration(seconds: 5),
        )
        .catchError((onError) {
          return {"status": false, "mensaje": "coneccion rechazada"};
        });
    print(response.statusCode);
    print(response);
    if (response != null &&
        response?.statusCode != null &&
        response.statusCode == 200) {
      print(response.body);
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      return {"status": false, "mensaje": "ruta invalido"};
    }
  }
}
