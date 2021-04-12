// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:tickets_geofence/src/providers/db.provider.dart';
// // import 'package:mobvertaxi_usuario/src/pages/login_pages/login_page.dart';
// // import 'package:splashscreen/splashscreen.dart';
// // import 'package:flutter_svg/flutter_svg.dart';

// class SplashScreenPage extends StatefulWidget {
//   SplashScreenPage({Key key}) : super(key: key);

//   @override
//   _SplashScreenPageState createState() => _SplashScreenPageState();
// }

// class _SplashScreenPageState extends State<SplashScreenPage> {
//   bool _sendPage = false;
//   DBProvider _db = DBProvider();
//   AppUpdateInfo _updateInfo;
//   // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     isLocationServiceEnabled();
//   }

//   isLocationServiceEnabled() async {
//     bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!isLocationServiceEnabled) {
//       try {
//         await Geolocator.openLocationSettings();
//       } catch (error) {
//         print("Error al abrir configuraciones ${error.toString()}");
//       }
//     }
//   }

//   Future<void> checkForUpdate() async {
//     _sendPage = true;
//     InAppUpdate.checkForUpdate().then((info) {
//       if (this.mounted)
//         setState(() {
//           _updateInfo = info;

//           if (_updateInfo?.updateAvailable != null &&
//               _updateInfo.updateAvailable) {
//             // _updateInfo.|
//             if (_updateInfo?.immediateUpdateAllowed != null &&
//                 _updateInfo.immediateUpdateAllowed) {
//               InAppUpdate.performImmediateUpdate()
//                   .whenComplete(() => _validateSession(context))
//                   .catchError((error) => _showError(error));
//             } else if (_updateInfo?.flexibleUpdateAllowed != null &&
//                 _updateInfo.flexibleUpdateAllowed) {
//               InAppUpdate.startFlexibleUpdate().then((_) {
//                 InAppUpdate.completeFlexibleUpdate().then((_) {
//                   _validateSession(this.context);
//                 });
//               });
//             }
//           } else {
//             _validateSession(this.context);
//           }
//         });
//     }).catchError((e) => _showError(e));
//   }

//   void _showError(dynamic exception) {
//     // _scaffoldKey.currentState
//     //     .showSnackBar(SnackBar(
//     //         backgroundColor: Colors.transparent,
//     //         duration: Duration(seconds: 1),
//     //         content: Text(exception.toString())))
//     //     .closed
//     //     .then((value) => _validateSession(context));

//     _validateSession(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Timer(Duration(seconds: 2), () {
//     //   if (!_sendPage) _validateSession(context);
//     // });

//     if (!_sendPage) {
//       checkForUpdate();
//     }

//     return Scaffold(
//       body: Stack(children: <Widget>[
//         Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               width: double.infinity,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [
//                 Color(0XFFC54284),
//                 Color(0xFF23396a),
//               ], begin: Alignment(0.3, 1.3), end: Alignment(3.0, 0.0))),
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(),
//                   ),
//                   Center(
//                     child: Image(
//                       color: Colors.white,
//                       image: AssetImage('assets/images/splash_screen/Logo.png'),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(20.0),
//                     child: Center(
//                         child: Image(
//                       height: 15.0,
//                       image:
//                           AssetImage('assets/images/splash_screen/MoverT.png'),
//                     )),
//                   ),
//                 ],
//               ),
//             )),
//       ]),
//     );
//   }

//   _validateSession(BuildContext context) async {
//     _sendPage = true;

//     final data = await _db.getToken();

//     if (data != '' &&
//         data != null &&
//         data.length > 0 &&
//         data[0]['token'] != null &&
//         data[0]["token"] != "") {
//       Navigator.popAndPushNamed(context, 'home');
//     } else {
//       Navigator.popAndPushNamed(context, 'login');
//     }
//   }
// }
