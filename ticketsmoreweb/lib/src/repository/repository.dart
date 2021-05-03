import 'package:flutter/foundation.dart';
import 'package:ticketsmoreweb/src/providers/geofences.provider.dart';
import 'package:ticketsmoreweb/src/providers/subroute.provider.dart';
import 'package:ticketsmoreweb/src/providers/rutas.dart';

class Repository {
  GeofencesProvider _geofencesProvider = GeofencesProvider();
  RutasProvider _rutas = RutasProvider();
  SubRutasProvider _subRutasProvider = SubRutasProvider();
  // RutasProvider _rutasProvider = RutasProvider();

  Future<Map<String, dynamic>> saveGeofence(
          {Map<String, dynamic> data}) async =>
      await _geofencesProvider.sendNewGeofence(data: data);

  Future<dynamic> getAllGeofences() async =>
      await _geofencesProvider.getAllGeofences();

  Future<dynamic> saveRoute(
          {Map<String, dynamic> ruta, List<dynamic> subroute}) async =>
      await _rutas.saveRoute(route: ruta, subroute: subroute);

  Future<dynamic> getRoute(idRoute) async =>
      await _rutas.getRouteEdit(idRoute: idRoute);

  Future<dynamic> getAllSubroutes(idRoute) async =>
      await _rutas.getSubroutesEdit(idRoute);
  // Future<dynamic> getAllSubRoutes(idRoute) async =>
  //     await _subRutasProvider.getSubroute(idSubroute: idRoute);

  // Future<dynamic> getDataRoute(idRoute) async =>
  //     await _rutasProvider.getRouteById(idRoute: idRoute);
}
