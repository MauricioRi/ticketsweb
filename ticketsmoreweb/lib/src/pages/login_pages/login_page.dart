// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   // CarouselController _buttonCarouselController = CarouselController();
//   int _colorprincipal = 0XFF00BFFF;
//   int _colorsecundario = 0XFF5858FA;
//   String _telefono = '';
//   String _email = '';
  
//   String _contraseña = '';
//   final _formKey = GlobalKey<FormState>();

//   StreamSubscription<ConnectivityResult> _subscription;
//   bool _isConnectedNetwork = true;

//   @override
//   void initState() {
//     super.initState();

//     _subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       // Got a new connectivity status!
//       _isConnectedNetwork = (result == ConnectivityResult.none) ? false : true;

//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _subscription?.cancel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(child: _createItemLogin(context)));
//   }

//   Widget _createItemLogin(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [
//           Color(_colorprincipal),
//           Color(_colorsecundario),
//         ], begin: Alignment(0.3, 1.3), end: Alignment(3.0, 0.0)),
//       ),
//       padding: EdgeInsets.all(20.0),
//       child: Center(
//         child: Column(
//           children: <Widget>[
//             Expanded(child: Container()),
//             Container(
//               padding: EdgeInsets.all(20.0),
//               // color: Colors.grey,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.15,
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     child: SvgPicture.asset(
//                       'assets/images/icons/bus.png',
//                       color: Theme.of(context).primaryColor,
//                       // width: MediaQuery.of(context).size.height * 0.15,
//                       // height: MediaQuery.of(context).size.width * 0.8,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Form(
//                       key: _formKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _textFieldUsr(context),
//                           SizedBox(height: 10.0),
//                           _textFieldUsr(context, ispassword: true),
//                         ],
//                       )),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   // Center(
//                   //     child: FlatButton(
//                   //   onPressed: () {
//                   //     if (_isConnectedNetwork)
//                   //       Navigator.pushNamed(context, "politicas");
//                   //     else
//                   //       messageNoConnectionNetwork();
//                   //   },
//                   //   child: Column(
//                   //     children: [
//                   //       Text(
//                   //           "Al iniciar sesión, acepta los términos y condiciones",
//                   //           textAlign: TextAlign.center,
//                   //           style: TextStyle(fontSize: 10)),
//                   //       Text("puedes ver los términos aquí",
//                   //           textAlign: TextAlign.center,
//                   //           style: TextStyle(fontSize: 10))
//                   //     ],
//                   //   ),
//                   // )),
//                   // SizedBox(
//                   //   height: 10.0,
//                   // ),
//                   _createButtonLogin(context)
//                 ],
//               ),
//             ),
//             Expanded(child: Container()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _textFieldUsr(BuildContext context, {bool ispassword = false}) {
//     return TextFormField(
//       validator: (value) {
//         if (value.isEmpty) {
//           return 'Este campo es obligatorio';
//         }
//         return null;
//       },
//       // keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
//           hintText: ispassword ? "Contraseña" : 'Email',
//           labelText: ispassword ? "Contraseña" : 'Email',
//           // helperText: 'Ingrese el teléfono registrado',
//           icon: Icon(ispassword ? Icons.lock_open : Icons.email)),
//       autofocus: false,
//       obscureText: ispassword,
//       onTap: () {},
//       // expands: true,
//       // inputFormatters: [
//       //   FilteringTextInputFormatter.deny(RegExp("[0-9]{12}"),
//       //       replacementString: '')
//       // ],
//       // maxLength: 10,
//       // minLines: 1,
//       // maxLines: 1,
//       onChanged: (email) {
//         //is
//         // _telefono = telefono;
//         _email = email;
//         _contraseña=email;
//       },
//     );
//   }

//   Widget _createButtonLogin(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         MaterialButton(
//           onPressed: () {
//             if (_formKey.currentState.validate()) {}
//           },
//           child: Text(
//             'Iniciar Sesión',
//             textAlign: TextAlign.center,
//           ),
//           minWidth: MediaQuery.of(context).size.width * 0.7,
//           textColor: Colors.white,
//           color: Theme.of(context).primaryColor,
//           padding: EdgeInsets.all(15.0),
//           splashColor: Colors.blueGrey,
//           elevation: 6.0,
//           highlightElevation: 2.0,
//           shape: StadiumBorder(),
//         ),
//       ],
//     );
//   }

//   void messageNoConnectionNetwork() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25.0)),
//             title: Center(
//               child: Column(
//                 children: [
//                   Image(
//                       image: AssetImage(
//                           "assets/images/splash_screen/LogoColor.png")),
//                   Text(
//                       "Error de conexión, favor de conectarse a una red WI-FI o red móvil para continuar")
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Aceptar'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   void _showMessageError(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(25.0)),
//             title: Text(
//               'Error al iniciar sesión',
//               textAlign: TextAlign.center,
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text('Posibles causas:'),
//                 Text(
//                   '- Campos vacios de inicio de sesión',
//                   textAlign: TextAlign.justify,
//                 ),
//                 Text(
//                   '- No existe la cuenta a la que desea acceder',
//                   textAlign: TextAlign.justify,
//                 )
//               ],
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 child: Text('Cerrar'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
