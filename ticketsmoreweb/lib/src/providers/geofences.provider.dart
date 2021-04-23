import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as _http;

class GeofencesProvider {
  Future<Map<String, dynamic>> sendNewGeofence(
      {Map<String, dynamic> data}) async {
    try {
      Uri url =
          Uri(port: 3000, host: "localhost", path: "/api/v1/user/newGeofence");

      final response = await _http.post(url, body: data);

      print(response.statusCode);

      if (response.statusCode == 201) {
        // if (response.body.runtimeType == String) {
        final jsonResponse = json.decode(response.body);

        return jsonResponse;
        // }
      } else {
        return {"status": true, "message": "Error al generar la geocerca"};
      }
    } on SocketException catch (e) {
      return {"status": false, "message": e.message};
    } on TimeoutException catch (e) {
      return {"status": false, "message": e.message};
    } on Exception catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }

  Future<dynamic> getAllGeofences() async {
    try {
      Uri url = Uri(
          port: 3000, host: "localhost", path: "/api/v1/user/getAllGeofences");

      final response = await _http.post(url);

      print(response.statusCode);

      if (response.statusCode == 200) {
        // if (response.body.runtimeType == String) {
        final jsonResponse = json.decode(response.body);

        return jsonResponse;
        // }
      } else {
        return {"status": true, "message": "Error al generar la geocerca"};
      }
    } on SocketException catch (e) {
      return {"status": false, "message": e.message};
    } on TimeoutException catch (e) {
      return {"status": false, "message": e.message};
    } on Exception catch (e) {
      return {"status": false, "message": e.toString()};
    }
  }
}
