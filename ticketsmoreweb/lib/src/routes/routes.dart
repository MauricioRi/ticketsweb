import 'package:flutter/material.dart';
import 'package:ticketsmoreweb/src/pages/geofence.dart';
// import 'package:tickets_geofence/src/pages/account_configuration_page.dart';
// import 'package:tickets_geofence/src/pages/initial_page/prueba_geocoder.dart';

//Paginas de usuario

// import 'package:tickets_geofence/src/pages/initial_page/splash_screen_page.dart';
// import 'package:tickets_geofence/src/pages/login_pages/login_page.dart';

// import 'package:tickets_geofence/src/pages/initial_page/splash_screen_page.dart';

import 'package:ticketsmoreweb/src/pages/home_page.dart';
import 'package:ticketsmoreweb/src/pages/login_page.dart';
import 'package:ticketsmoreweb/src/pages/rutas.dart';
import 'package:ticketsmoreweb/src/pages/subrrutas.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // '/': (BuildContext context) => SplashScreenPage(),
    // 'home': (BuildContext context) => HomePage(),
    // 'login': (BuildContext context) => LoginPage(),
    // 'register': (BuildContext context) => RegistrarPage(),
    // 'validateLogin': (BuildContext context) => ValidatePage(),
    // 'metodoPagos': (BuildContext context) => MetodosPagoPage(),
    // 'servicios': (BuildContext context) => ServiciosPage(),
    // 'email': (BuildContext context) => RegisterEmailPage(),
    // 'pr': (BuildContext context) => ExamplePage(),
    // 'califica': (BuildContext context) => CalificacionPage(),
    // 'historial': (BuildContext context) => HistorialPage(),
    // 'viaje': (BuildContext context) => DetailsTravelPage(),
    // 'reporte': (BuildContext context) => ReportProblemPage(),
    // 'seleccionpagopage': (BuildContext context) => SeleccionPagoPage(),
    // 'iniciopagopage': (BuildContext context) => InicioPagosPage(),
    // 'registrartarjetapage': (BuildContext context) => RegistrarTarjetaPage(),
    // 'aplicarpagopage': (BuildContext context) => AplicarPagoPage(),
    // 'configurationpage': (BuildContext context) => ConfigurationPage(),
    // 'contactosConfianza': (BuildContext context) => ContactosConfianzaPage(),
    // 'contactosList': (BuildContext context) => ContactosListPage(),
    // 'messenger': (BuildContext context) => MessagesPage(),
    // 'account': (BuildContext context) => AccountConfiguration(),
    // 'permisos': (BuildContext context) => PermissionsReasonsPage(),
    // 'politicas': (BuildContext context) => PoliticasPrivacidadPage(),
    // 'calificaTardio': (BuildContext context) => CalificacionTardioPage()

    'login': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'Mapa': (BuildContext context) => GeofenceMap(),
    'Rutas': (BuildContext context) => Rutas(),
    'subrutas': (BuildContext context) => Subrutas(),
  };
}
