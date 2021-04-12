import 'dart:collection';
import 'dart:html';
import 'package:flutter/material.dart' hide Animation;
import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps/google_maps.dart' hide Icon hide Geocoder;
import 'package:geocode/geocode.dart';
import 'dart:ui' as ui;

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
  // Set<Circle> _circles = HashSet<Circle>();
  dynamic id;
  GMap map;
  GeoCode geoCode = GeoCode();
  MapOptions mapOptions;
  DivElement elem;
  List<Marker> marcadores = [];
  List<Circle> circles = [];
  // Map<MarkerId, Marker> _markers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registra una nueva geocerca"),
        automaticallyImplyLeading: true,
        elevation: 20.0,
      ),
      body:
          // SingleChildScrollView(
          //   child:
          Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Card(
                  elevation: 20.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          padding: EdgeInsets.all(15.0),
                          child: Text("Nueva geocerca",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                              // FittedBox(
                              //   child:
                              // Text(
                              //   "Nombre de la geocerca",
                              //   textAlign: TextAlign.left,
                              // ),
                              // ),
                              SizedBox(
                                height: 10.0,
                              ),
                              generateTextField(1),
                              // FittedBox(
                              //   child:
                              // Text("Dirección central",
                              //     textAlign: TextAlign.left),
                              SizedBox(
                                height: 10.0,
                              ),
                              // ),
                              generateTextField(2),
                              // FittedBox(
                              //   child:
                              // Text("Radio de la geocerca",
                              //     textAlign: TextAlign.left),
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
        print(event.latLng);
        if (_isSearchInMap == 2) {
          _ubicacion = event.latLng;

          Address direccion = await geoCode.reverseGeocoding(
              latitude: event.latLng.lat, longitude: event.latLng.lng);
          print(direccion);
          _direccion.text = direccion.toString();

          // map = new GMap(elem, mapOptions);
          // map.data.remove(DataFeature().)
          // map.div.removeAttribute("center");
          // map.controls.removeLast();
          //
          marcadores.length > 0 ? marcadores[0].visible = false : null;

          circles.length > 0 ? circles[0].visible = false : null;

          marcadores = [
            Marker(MarkerOptions()
              ..position = _ubicacion
              ..map = map
              ..animation = Animation.BOUNCE
              ..title = _direccion.text)
          ];

          // a.opacity = 0;

          _isActionInProgress = false;
          _isSearchInMap = 0;
          if (this.mounted) setState(() {});
        } else if (_isSearchInMap == 3) {
          print(event.latLng);

          if (_ubicacion != null) {
            print(event.latLng);

            final double distance = Geolocator.distanceBetween(event.latLng.lat,
                event.latLng.lng, _ubicacion.lat, _ubicacion.lng);
            _distancia.text = distance.toStringAsFixed(2);

            // map.data.remove(DataFeature().id);
            // Circle(CircleOptions()).
            //

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

      // Marker(MarkerOptions()
      //   ..position = myLatlng
      //   ..map = map
      //   ..title = 'Hello World!');

      return elem;
    });

    return HtmlElementView(viewType: htmlId);
    // return GoogleMap(
    // circles: _circles,
    // // markers: ,//Set<Marker>.of(_markers?.values),
    // compassEnabled: true,
    // myLocationEnabled: true,
    // rotateGesturesEnabled: true,
    // onTap: _isActionInProgress
    //     ? (locationMap) async {
    //         if (_isSearchInMap == 2) {
    //           _ubicacion = locationMap;
    //           List<Address> direccion = await Geocoder.local
    //               .findAddressesFromCoordinates(Coordinates(
    //                   locationMap.latitude, locationMap.longitude));
    //           _direccion.text = direccion.first.addressLine;

    //           //Generamos el marcador

    //           _markers[MarkerId("Centro")] = Marker(
    //               markerId: MarkerId("Centro"),
    //               position: _ubicacion,
    //               draggable: false,
    //               infoWindow: InfoWindow(
    //                   snippet: "${_direccion?.text}",
    //                   title: "Ubicación central de la geocerca"));

    //           _isActionInProgress = false;
    //           _isSearchInMap = 0;
    //           if (this.mounted) setState(() {});
    //         } else if (_isSearchInMap == 3) {
    //           if (_ubicacion != null) {
    //             final double distance = Geolocator.distanceBetween(
    //                 locationMap.latitude,
    //                 locationMap.longitude,
    //                 _ubicacion.latitude,
    //                 _ubicacion.longitude);
    //             _distancia.text = distance.toString();

    //             _circles.clear();

    //             //Generamos la geocerca visualmente
    //             _circles.add(Circle(
    //                 circleId: CircleId("Radio"),
    //                 radius: distance,
    //                 center: _ubicacion,
    //                 fillColor: Theme.of(context).primaryColor,
    //                 strokeColor: Theme.of(context).accentColor));

    //             _isActionInProgress = false;
    //             _isSearchInMap = 0;
    //             if (this.mounted) setState(() {});
    //           } else {
    //             showAlert(
    //                 "Favor de seleccionar la ubicación central de la geocerca para establecer el radio de la misma");
    //           }
    //         }
    //       }
    //     : null,
    // initialCameraPosition: CameraPosition(target: LatLng(19.01, -101.158)));
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

                RegExp regex = RegExp(r'/^[0-9]*[\.]{0,1}[0-9]{0,2}$/');

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
                      // map = new GMap(elem, mapOptions);

                      // Marker(MarkerOptions())
                      //   ..position = _ubicacion
                      //   ..map = map
                      //   ..title = _direccion.text;
                      circles.length > 0 ? circles[0].visible = false : null;

                      circles = [
                        Circle(CircleOptions()
                          ..center = _ubicacion
                          ..map = map
                          ..radius = val
                          ..editable = false
                          ..draggable = false
                          ..clickable = true)
                      ];
                      // _circles.clear();
                      //Generamos la geocerca visualmente
                      // _circles.add(Circle(
                      //     circleId: CircleId("Radio"),
                      //     radius: value as double,
                      //     center: _ubicacion,
                      //     fillColor: Theme.of(context).primaryColor,
                      //     strokeColor: Theme.of(context).accentColor));

                      if (this.mounted) setState(() {});
                    } else {
                      showAlert(
                          "Favor de seleccionar la ubicación central de la geocerca para establecer el radio de la misma");
                    }
                  } catch (e) {
                    circles.length > 0 ? circles[0].visible = false : null;

                    // showAlert(e.toString());
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
                        : "Radio de la geocerca",
              ),
            ),
          ),
        ),
        type == 2 || type == 3
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  type == 2
                      ? IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            //Se llama la api de google places
                          })
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

  saveGeofence() {
    if (_globalKey.currentState.validate()) {
      //Enviar datos para su validación
    } else {
      //Mostrar error de datos erroneos
      showAlert("Información registrada invalida");
    }
  }

  showAlert(message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Text("$message"),
        ),
        title: Text(
          "Advertencía",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Aceptar"))
        ],
      ),
    );
  }
}
