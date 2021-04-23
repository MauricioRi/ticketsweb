import 'package:flutter/foundation.dart';
import 'package:ticketsmoreweb/src/providers/geofences.provider.dart';

class Repository {
  GeofencesProvider _geofencesProvider = GeofencesProvider();

  Future<Map<String, dynamic>> saveGeofence(
          {Map<String, dynamic> data}) async =>
      await _geofencesProvider.sendNewGeofence(data: data);

  Future<dynamic> getAllGeofences() async =>
      await _geofencesProvider.getAllGeofences();
}
