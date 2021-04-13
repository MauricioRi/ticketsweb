import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ticketsmoreweb/src/bloc/provider.dart';
// import 'package:ticketsmoreweb/src/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  BuildContext scafoldcontext;
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();

  // Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  // Map<PolylineId, Polyline> _polylines = {};
  // CameraPosition _kGooglePlex = CameraPosition(
  //     target: LatLng(19.7025, -101.19250000000001),
  //     zoom: 15.2569); //Variable para establecer la ubicacion inicial del mapa
  // Completer<GoogleMapController> _controller =
  //     Completer(); //Controlador para poder indicar que se ha cargado el mapa
  // GoogleMapController
  //     _mapController; //Controlador para acceder a la informacion del mapa

  @override
  void initState() {
    super.initState();
    // _kGooglePlex = CameraPosition(
    //     target: LatLng(19.7025, -101.19250000000001), zoom: 15.2569);
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = Provider.of(context);
    final Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments;
    //'Email: ${bloc.email}'),
    // Text('Password: ${bloc.password}'),
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text("rutas de " + arguments["Name_user"] ?? ""),
      ),
      body: Builder(builder: (context) {
        scafoldcontext = context;
        // setState(() {});
        return SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(60.0),
            child: Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        );
      }),
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // DrawerHeader(
          //   child: Text('Drawer Header'),
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          // ),
          ListTile(
            title: Text('rutas'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
              Navigator.pushNamed(
                context,
                'Rutas',
                arguments: ScreenArguments(
                  arguments["Name_user"],
                  arguments["idusersystem"],
                  arguments["idroute"],
                ),
              );
              //  Scaffold.of(scafoldcontext).openEndDrawer();
            },
          ),
          ListTile(
            title: Text('Subrutas'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
              // Scaffold.of(scafoldcontext).openEndDrawer();
            },
          ),
        ],
      )),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  //List<String> ruta = List.of({"ruta1", "ruta2"});
  String rutass = "rutas ";
  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.car_rental,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'nombre de la ruta',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.timelapse_sharp,
            TextFormField(
              controller: mobileCtrl,
              decoration: new InputDecoration(
                labelText: 'numero de minutos de ruta',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: validateMobile,
            )),
        formItemsDesign(
            null,
            Column(children: <Widget>[
              Text("subrruta"),
              RadioListTile<String>(
                title: const Text('charo'),
                value: 'charo',
                groupValue: rutass,
                onChanged: (value) {
                  setState(() {
                    rutass = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('morelia'),
                value: 'morelia',
                groupValue: rutass,
                onChanged: (value) {
                  setState(() {
                    rutass = value;
                  });
                },
              )
            ])),
        // formItemsDesign(
        //     Icons.email,
        //     TextFormField(
        //       controller: emailCtrl,
        //       decoration: new InputDecoration(
        //         labelText: 'Email',
        //       ),
        //       keyboardType: TextInputType.emailAddress,
        //       maxLength: 32,
        //       validator: validateEmail,
        //     )),
        // formItemsDesign(
        //     Icons.remove_red_eye,
        //     TextFormField(
        //       controller: passwordCtrl,
        //       obscureText: true,
        //       decoration: InputDecoration(
        //         labelText: 'Contraseña',
        //       ),
        //     )
        //     ),
        // formItemsDesign(
        //     Icons.remove_red_eye,
        //     TextFormField(
        //       controller: repeatPassCtrl,
        //       obscureText: true,
        //       decoration: InputDecoration(
        //         labelText: 'Repetir la Contraseña',
        //       ),
        //       validator: validatePassword,
        //     )),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  String validatePassword(String value) {
    print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "los minutos son necesarios";
    } else if (value.length > 0) {
      return "El numero debe ser mayo a 0";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Telefono ${mobileCtrl.text}");
      print("Correo ${emailCtrl.text}");
      keyForm.currentState.reset();
    }
  }
}

class ScreenArguments {
  final String nameuser;
  final String iduser;
  final String idroute;
  ScreenArguments(this.nameuser, this.iduser, this.idroute);
}
