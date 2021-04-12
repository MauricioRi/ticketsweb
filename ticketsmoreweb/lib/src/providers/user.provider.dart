import 'package:flutter/foundation.dart';
import '../models/user.model.dart';
import 'package:http/http.dart' as http;
import 'baseUrl.dart';
import 'dart:convert';

class UserProvider {
  BaseUrl _url = BaseUrl();

  Future<Map<String, dynamic>> login(
      {@required String email, @required String pws}) async {
    Uri url = Uri.http(_url.getBaseUrl(), _url.getNextUrl() + "/login");
    print(url);
    final response = await http
        .post(url, body: {"email": email, "password": pws})
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
      return {"status": false, "mensaje": "user invalido"};
    }
  }
}
