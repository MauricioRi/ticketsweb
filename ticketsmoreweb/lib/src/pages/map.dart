import 'dart:html';
import 'package:flutter/material.dart' hide Animation;
import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps/google_maps.dart' hide Icon hide Geocoder;
import 'package:geocode/geocode.dart';
import 'dart:ui' as ui;
import 'package:ticketsmoreweb/src/repository/repository.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_google_places_api/flutter_google_places_api.dart';

class GeofenceMap extends StatefulWidget {
  @override
  _GeofenceMapState createState() => _GeofenceMapState();
}

class _GeofenceMapState extends State<GeofenceMap> {
  final GlobalKey mapContainer = GlobalKey();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _nombre = TextEditingController();
  TextEditingController _distancia = TextEditingController();
  TextEditingController _direccion = TextEditingController();
  LatLng _ubicacion;
  bool _isActionInProgress = false;
  int _isSearchInMap = 0;
  bool searchGoogle = false;
  dynamic id;
  GMap map;
  GeoCode geoCode = GeoCode();
  MapOptions mapOptions;
  DivElement elem;
  List<Marker> marcadores = [];
  List<Circle> circles = [];
  Widget listView;
  Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registra una nueva geocerca"),
        automaticallyImplyLeading: true,
        elevation: 20.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Card(
                  elevation: 20.0,
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            padding: EdgeInsets.all(15.0),
                            child: Text("Nueva geocerca",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          _isActionInProgress
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.yellow[200]),
                                  child: Text(
                                      "Favor de seleccionar un punto en el mapa para ejecutar la acción",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )
                              : Container(),
                          SizedBox(
                            height: 5.0,
                          ),
                          _isActionInProgress
                              ? cancelActionButton()
                              : Container(),
                          Form(
                            key: _globalKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                generateTextField(1),
                                SizedBox(
                                  height: 10.0,
                                ),
                                generateTextField(2),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  child: listView,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                // ),
                                generateTextField(3),
                                SizedBox(
                                  height: 10.0,
                                ),
                                buttonSave()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Expanded(
                key: mapContainer,
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: mapGoogle(),
                )),
          ],
        ),
      ),
      // ),
    );
  }

  mapGoogle() {
    String htmlId = "7";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      // final myLatlng = new LatLng(30.2669444, -97.7427778);

      mapOptions = new MapOptions()
        ..zoom = 8
        ..center = LatLng(30.2669444, -97.7427778);

      elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      map = new GMap(elem, mapOptions);

      map.onClick.listen((event) async {
        if (_isSearchInMap == 2) {
          _ubicacion = event.latLng;
          print(event.latLng);

          Address direccion = await geoCode.reverseGeocoding(
              latitude: event.latLng.lat, longitude: event.latLng.lng);
          print(direccion);
          _direccion.text = direccion?.city;

          marcadores.length > 0 ? marcadores[0].visible = false : null;

          circles.length > 0 ? circles[0].visible = false : null;

          marcadores = [
            Marker(MarkerOptions()
              ..position = _ubicacion
              ..map = map
              ..animation = Animation.BOUNCE
              ..title = _direccion.text)
          ];

          _isActionInProgress = false;
          _isSearchInMap = 0;
          if (this.mounted) setState(() {});
        } else if (_isSearchInMap == 3) {
          print(event.latLng);

          if (_ubicacion != null) {
            print(event.latLng);

            final double distance = Geolocator.distanceBetween(event.latLng.lat,
                event.latLng.lng, _ubicacion.lat, _ubicacion.lng);
            _distancia.text = (distance / 1000).toStringAsFixed(2);

            circles.length > 0 ? circles[0].visible = false : null;

            circles = [
              Circle(CircleOptions()
                ..center = _ubicacion
                ..map = map
                ..radius = distance
                ..editable = false
                ..clickable = true
                ..draggable = false)
            ];

            _isActionInProgress = false;
            _isSearchInMap = 0;
            if (this.mounted) setState(() {});
          }
        }
      });

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }

  generateTextField(int type) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              enabled: !_isActionInProgress,
              readOnly: type == 2 ? true : false,
              controller: type == 1
                  ? _nombre
                  : type == 2
                      ? _direccion
                      : _distancia,
              validator: (value) {
                if (type == 1) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "El nombre de la ruta no puede ser vació";
                  }
                }

                if (type == 2) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "dirección no valida";
                  }
                }

                RegExp regex = RegExp(r'^[0-9]+[\.]{0,1}[0-9]{0,2}$');

                if (value.isNotEmpty && regex.hasMatch(value)) {
                  return null;
                } else {
                  return "Distancía no valida";
                }
              },
              onChanged: (value) {
                if (type == 3) {
                  try {
                    if (_ubicacion != null) {
                      double val = double.parse(value.length == 0 ? "" : value);

                      circles.length > 0 ? circles[0].visible = false : null;

                      circles = [
                        Circle(CircleOptions()
                          ..center = _ubicacion
                          ..map = map
                          ..radius = (val * 1000)
                          ..editable = false
                          ..draggable = false
                          ..clickable = true)
                      ];

                      if (this.mounted) setState(() {});
                    } else {
                      showAlert(
                          "Favor de seleccionar la ubicación central de la geocerca para establecer el radio de la misma");
                    }
                  } catch (e) {
                    circles.length > 0 ? circles[0].visible = false : null;

                    showAlert("Favor de introducir un valor numerico");
                  }
                }
              },
              keyboardType:
                  type == 3 ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(type == 1
                    ? Icons.app_registration
                    : type == 2
                        ? Icons.location_pin
                        : Icons.confirmation_number_outlined),
                hintText: type == 1
                    ? "Nombre de la geocerca"
                    : type == 2
                        ? "Dirección central de la geocerca"
                        : "Radio de la geocerca",
                labelText: type == 1
                    ? "Nombre de la geocerca"
                    : type == 2
                        ? "Dirección central de la geocerca"
                        : "Radio de la geocerca (km)",
              ),
            ),
          ),
        ),
        type == 2 || type == 3
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  type == 2
                      ? Container()
                      // ? IconButton(
                      //     icon: Icon(Icons.search),
                      //     onPressed: !searchGoogle
                      //         ? () {
                      //             //Se llama la api de google places
                      //             setState(() {
                      //               // getUbications();
                      //             });
                      //           }
                      //         : null)
                      : Container(),
                  IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {
                        setState(() {
                          _isSearchInMap = type;
                          _isActionInProgress = true;
                        });
                      })
                ],
              )
            // )
            : Container()
      ],
    );
  }

  cancelActionButton() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: MaterialButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.cancel),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Cancelar acción",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              )
            ],
          ),
          onPressed: () {
            setState(() {
              _isSearchInMap = 0;
              _isActionInProgress = false;
            });
          }),
    );
  }

  buttonSave() {
    return Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Theme.of(context).primaryColor),
        child: MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.save),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Guardar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                )
              ],
            ),
            onPressed: saveGeofence));
  }

  // getUbications() async {
  //   if (_direccion.text == null || _direccion.text == "")
  //     listView = Container();
  //   try {
  //     print(_direccion.text);
  //     PlaceAutocompleteResponse response = await PlaceAutocompleteRequest(
  //             // location: Location(lat: 19.7025, lng: -101.19250000000001),
  //             radius: 40,
  //             language: 'es-Es',
  //             key: 'AIzaSyCg3BHJXNLYrNXqUlhAEnRX41f42pRn_mY',
  //             input: '${_direccion.text}')
  //         .call();
  //     print(_direccion.text);

  //     Map<String, dynamic> places = response.toJson();
  //     List<Widget> items = <Widget>[];

  //     places['predircts'].forEach((value) async {
  //       // Coordinates direction = await geoCode.forwardGeocoding(address: value.description.toString());
  //       // LatLng ubic = LatLng(direction.latitude, direction.longitude);
  //       // // _ubicacion = ubic;
  //       items
  //         ..add(ListTile(
  //           leading: Icon(Icons.location_on),
  //           title: Text(
  //             value.terms[0].value,
  //             overflow: TextOverflow.fade,
  //           ),
  //           subtitle: Text(
  //             value.description.toString(),
  //             overflow: TextOverflow.fade,
  //           ),
  //           onTap: () async {
  //             Coordinates direction = await geoCode.forwardGeocoding(
  //                 address: value.description.toString());
  //             LatLng ubic = LatLng(direction.latitude, direction.longitude);
  //             _ubicacion = ubic;

  //             marcadores.length > 0 ? marcadores[0].visible = false : null;

  //             circles.length > 0 ? circles[0].visible = false : null;

  //             marcadores = [
  //               Marker(MarkerOptions()
  //                 ..position = _ubicacion
  //                 ..map = map
  //                 ..animation = Animation.BOUNCE
  //                 ..title = _direccion.text)
  //             ];
  //           },
  //         ))
  //         ..add(Divider());
  //     });

  //     listView = ListView(
  //       children: items,
  //       padding: EdgeInsets.all(10.0),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  saveGeofence() async {
    if (_globalKey.currentState.validate()) {
      //Enviar datos para su validación
      //
      final Map<String, dynamic> response =
          await _repository.saveGeofence(data: {
        "name": _nombre.text,
        "description": _direccion.text,
        "centro_latitude": _ubicacion.lat.toString(),
        "centro_longitude": _ubicacion.lng.toString(),
        "radio": _distancia.text
      });

      print(response);

      if (response.containsKey("status") && !response["status"]) {
        showAlert(response["message"]);
      } else if (response["status"]) {
        showAlert(response["message"], isSuccess: true);
      }
    } else {
      //Mostrar error de datos erroneos
      showAlert("Información registrada invalida");
    }
  }

  showAlert(message, {bool isSuccess = false}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Text("$message"),
        ),
        title: Text(
          !isSuccess ? "Advertencía" : "Aviso",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (!isSuccess)
                  Navigator.pop(context);
                else {
                  marcadores.length > 0 ? marcadores[0].visible = false : null;

                  circles.length > 0 ? circles[0].visible = false : null;
                  _ubicacion = null;
                  _direccion.text = "";
                  _distancia.text = "";
                  _nombre.text = "";

                  setState(() {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Aceptar"))
        ],
      ),
    );
  }
}
