import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider bd = DBProvider._();

  DBProvider._();

  DBProvider();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'MoverT.db');

    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Usuario ('
          'id INTEGER PRIMARY KEY,'
          'celular TEXT,'
          'fecha Date,'
          'email TEXT'
          ')');

      await db.execute('CREATE TABLE token ('
          'token TEXT, '
          'public_key TEXT'
          ')');

      await db.insert('token', {"token": "", "public_key": ""});

      await db.execute('CREATE TABLE pagos ('
          'numeroTarjeta TEXT, '
          'fechaVencimiento TEXT, '
          'codigoSeguridad TEXT, '
          'seleccionado INTEGER, '
          'tipoPago INTEGER'
          ')');

      await db.execute('CREATE TABLE servicioActual ('
          'idServicio INTEGER, '
          'nombreServicio TEXT, '
          'descripcion TEXT'
          ')');

      await db.execute('CREATE TABLE viajeActual ('
          'idViaje INTEGER, '
          'idProcesoActual INTEGER '
          ')');
      await db.insert('viajeActual', {"idViaje": "0", "idProcesoActual": "0"});

      await db.execute('CREATE TABLE chatActual ('
          'idViaje INTEGER, '
          'msg TEXT, '
          'sinLeer INTEGER '
          ')');
      await db
          .insert('chatActual', {"idViaje": "0", "msg": "", "sinLeer": "0"});

      await db.execute('CREATE TABLE metodoPago ('
          'id INTEGER, '
          'tipoPago TEXT'
          ')');

      await db.execute('CREATE TABLE coordenadas ('
          'tipo TEXT, '
          'name TEXT, '
          'lat DOUBLE, '
          'lng DOUBLE'
          ')');

      await db.insert('pagos', {
        "numeroTarjeta": "EFECTIVO",
        "fechaVencimiento": "N/A",
        "codigoSeguridad": "NA",
        "seleccionado": 1,
        "tipoPago": 1
      });

      await db.execute('CREATE TABLE validateTrip ('
          'validate INT, '
          'destination INT)');

      await db.insert('validateTrip', {"validate": 0, "destination": 0});

      await db.execute('CREATE TABLE coordinates_without_internet ('
          'latitud DOUBLE,'
          'longitude DOUBLE,'
          'fecha TEXT'
          ')');
    });
  }

  saveMethod(List<dynamic> metodo) async {
    final db = await database;
    await db.delete('metodoPago');

    await db.insert('metodoPago', {"id": metodo[0], "tipoPago": metodo[1]});

    return {"status": true};
  }

  getMethodPayment() async {
    final db = await database;

    final response = await db.query('metodoPago', columns: ['id', 'tipoPago']);

    return response;
  }

  getCelular() async {
    final db = await database;

    final result = db.query('Usuario', columns: ['celular']);

    return result;
  }

  getEmail() async {
    final db = await database;

    final result = db.query('Usuario', columns: ['email']);

    return result;
  }

  saveEmail(String email) async {
    final db = await database;

    final result = db.update('Usuario', {"email": email});
  }

  nuevoIngreso(String celular, String email) async {
    final db = await database;

    final fecha = DateTime.now();

    await db.delete('Usuario');

    final res = db.insert('Usuario', {
      'id': 1,
      'celular': celular,
      'fecha': '${fecha.year}-${fecha.month}-${fecha.day}',
      'email': email
    });

    return res;
  }

  getToken() async {
    final db = await database;

    final response = db.query('token', columns: ['token', 'public_key']);

    if (response != null) {
      return response;
    } else {
      return '';
    }
  }

  guardarToken(Map<String, dynamic> usuario) async {
    final db = await database;
    final token = await db.query('token');
    Map<String, dynamic> dataUpdate;

    if (token.length > 0 && token[0]["token"] != "") {
      dataUpdate = {"token": usuario["token"]};

      final res = db.update('token', dataUpdate);

      return res;
    } else {
      dataUpdate = {
        "token": usuario["token"],
        "public_key": usuario["public_key"]
      };

      final res = await db.update('token', dataUpdate);

      return res;
    }
  }

  guardarMetodoPago(Map<String, dynamic> pago) async {
    final db = await database;

    final res = db.insert('pagos', {
      "numeroTarjeta": pago['numeroTarjeta'],
      "fechaVencimiento": pago['fechaVencimiento'],
      "codigoSeguridad": pago['codigoSeguridad'],
      "seleccionado": 0,
      "tipoPago": 2
    });

    return res;
  }

  eliminarMetodoPago(String numeroTarjeta) async {
    final db = await database;

    final res = db.delete('pagos', whereArgs: [numeroTarjeta]);

    return res;
  }

  modificarMetodoPago(Map<String, dynamic> pago) async {
    final db = await database;

    final res = db.update('pagos', {
      "fechaVencimiento": pago['fechaVencimiento'],
      "codigoSeguridad": pago['codigoSeguridad'],
    }, whereArgs: [
      pago['numeroTarjeta']
    ]);

    return res;
  }

  seleccionarMetodoPago(String numeroTarjeta) async {
    final db = await database;

    db.update('pagos', {"seleccionado": 0});

    final res =
        db.update('pagos', {"seleccionado": 1}, whereArgs: [numeroTarjeta]);

    return res;
  }

  guardarServicio(dynamic linea) async {
    final db = await database;

    await db.delete('servicioActual');

    final res = await db.insert('servicioActual', {
      "idServicio": linea[0],
      "nombreServicio": linea[1],
      "descripcion": linea[2]
    });

    return res;
  }

  getService() async {
    final db = await database;

    final res = await db.query('servicioActual');

    return res;
  }

  guardarMetodo(Map<String, dynamic> metodos) async {
    final db = await database;

    await db.delete('metodoPago');

    final res = await db.insert('metodoPago',
        {"id": metodos['idpayment_methods'], "tipoPago": metodos['method']});

    return res;
  }

  saveCoordenada(Map<String, dynamic> posicion) async {
    final db = await database;

    await db.delete('coordenadas', where: "tipo = '${posicion['route']}'");

    await db.insert('coordenadas', {
      "tipo": posicion['route'],
      "name": posicion['directionName'],
      "lat": posicion['coordenates']['lat'],
      "lng": posicion['coordenates']['lng']
    });

    return true;
  }

  deleteCoordenates() async {
    final db = await database;

    final res = db.delete('coordenadas');

    return res;
  }

  getCoordenadas() async {
    final db = await database;

    final res = db.query('coordenadas');

    return res;
  }

  closeSession() async {
    final db = await database;

    await db.update('token', {"token": "", "public_key": ""});
    await db.delete('Usuario');

    return {"status": true};
  }

  currentTrip(int idViaje, int idProceso) async {
    final db = await database;

    // await db.delete('viajeActual');

    final res = await db.update(
        'viajeActual', {"idViaje": idViaje, "idProcesoActual": idProceso});

    return res;
  }

  chatTrip(int idViaje, String msg) async {
    final db = await database;

    await db.delete('chatActual');

    final res = await db.insert('chatActual', {"idViaje": idViaje, "msg": msg});

    return res;
  }

  getTrip() async {
    final db = await database;

    final res = await db.query('viajeActual');

    return res;
  }

  saveValidateTrip(int status, int destination) async {
    final db = await database;

    Map<String, int> row = {};

    if (status < 2) row["validate"] = status;

    if (destination < 2) row["destination"] = destination;

    final res = await db.update('validateTrip', row);

    return res;
  }

  getValidateTrip() async {
    final db = await database;

    final res = await db.query('validateTrip');

    return res[0];
  }

  insertCoordinate({double lat, double lng}) async {
    final db = await database;

    final dateTime = DateTime.now();

    await db.insert('coordinates_without_internet', {
      'latitud': lat,
      'longitude': lng,
      'fecha':
          '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}'
    });
  }

  getAllCoordinates() async {
    final db = await database;

    final res = await db.query('coordinates_without_internet');

    return res;
  }

  deleteCoordinates() async {
    final db = await database;

    await db.delete('coordinates_without_internet');
  }
}
