import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:ticketsmoreweb/src/models/LocalUser.dart';


GetIt getIt = GetIt.instance;

class SimpleRequests {

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    var response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200) {
      return  convert.jsonDecode(response.body);
    } else return null;

  }

  Future<dynamic> getRaw(String url, {Map<String, String> headers}) async {
    var response = await http.get(Uri.parse(url), headers: headers);

    if(response.statusCode == 200) {
      return response.body;
    } else return null;

  }

  Future<dynamic> post(String url, {Map<String, String> headers, Map<String, dynamic> body}) async {
    headers.putIfAbsent('token', () => getIt.get<LocalUser>().token!=''? getIt.get<LocalUser>().token:'');
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    var jsonResponse = convert.jsonDecode(response.body);

    return jsonResponse;
  }


  Future<dynamic> put(String url, {Map<String, String> headers, Map<String, dynamic> body}) async {
    headers.putIfAbsent('token', () => getIt.get<LocalUser>().token!=''? getIt.get<LocalUser>().token:'');
    var response = await http.put(Uri.parse(url), headers: headers, body: body);
    var jsonResponse = convert.jsonDecode(response.body);

    return jsonResponse;
  }

  Future<dynamic> delete(String url, {Map<String, String> headers}) async {
    var response = await http.delete(Uri.parse(url), headers: headers,);
    var jsonResponse = convert.jsonDecode(response.body);

    return jsonResponse;
  }

}