import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';
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

  Future<Map<String, dynamic>> getRouteEdit({@required String idRoute}) async {
    Uri url = Uri.http(_url.getBaseUrl(),
        _url.getNextUrl() + "/getRoute/$idRoute"); //del archivo routes
    print(url);
    final response = await http
        .post(url)
        .timeout(
          Duration(seconds: 5),
        )
        .catchError((onError) {
      return throw ("coneccion rechazada");
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

  Future<dynamic> getSubroutesEdit(idRoute) async {
    try {
      Uri url = Uri.http(_url.getBaseUrl(),
          _url.getNextUrl() + "/getAllSubroutes/$idRoute"); //del archivo routes
      print(url);
      final response = await http
          .post(url)
          .timeout(
            Duration(seconds: 5),
          )
          .catchError((onError) {
        return throw ("coneccion rechazada");
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
        throw ("Error al obtener la subruta");
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  Future<dynamic> saveRoute(
      {Map<String, dynamic> route, List<dynamic> subroute}) async {
    try {
      Uri url = Uri.http(_url.getBaseUrl(),
          _url.getNextUrl() + "/newRoute"); //del archivo routes

      print(url.path);
      print(url.host);
      final response = await http
          .post(url, body: {
            // "id_city": 1,
            "Name_route": route["name"],
            "description": route["description"]
          })
          .timeout(
            Duration(seconds: 5),
          )
          .catchError((onError) {
            print(onError.toString());
            return throw ("coneccion rechazada");
          });
      print(response.statusCode);
      if (response != null && response.statusCode == 201) {
        // print(response.body);
        final jsonResponse = json.decode(response.body);

        if (subroute.length > 0) {
          Uri url2 = Uri.http(
              _url.getBaseUrl(),
              _url.getNextUrl() +
                  "/newSubRoute/" +
                  jsonResponse["id"].toString());

          print(url2.path);
          print({"subroutes": json.encode(subroute)});
          final response2 = await http
              .post(url2,
                  headers: {"content-type": "application/json; charset=utf-8"},
                  body: json.encode({"subroutes": subroute}))
              .timeout(
                Duration(seconds: 5),
              )
              .catchError((onError) {
            print(onError.toString());
            return throw "coneccion rechazada";
          });
          print(response2.body);

          final jsonResponse2 = json.decode(response2.body);
          print(response2.statusCode);

          if (response2.statusCode == 201 && jsonResponse2["status"]) {
            return jsonResponse2;
          } else
            throw ("Error al registrar la subruta");
        } else
          return {"status": true, "message": "Ruta creada con éxito"};
        // return jsonResponse;
      } else {
        return {"status": false, "message": "Error al generar la ruta"};
      }
    } catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }
}
