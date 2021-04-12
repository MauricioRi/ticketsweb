import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ticketsmoreweb/src/bloc/provider.dart';
import 'package:status_alert/status_alert.dart';

class LoginPage extends StatelessWidget {
  dynamic blocG;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  // startStream(context) {
  //   blocG.login.listen((event) {
  //       print(event);
  //       if (event) {
  //         Navigator.pushReplacementNamed(context, 'home');
  //       }
  //     }, onError: (error) {
  //       print("error: " + error.toString());
  //       print('================');
  //       print(
  //           'Email: ${blocG.email}'); //es por esta funcion:  String get password =>
  //       print('Password: ${blocG.password}');
  //       print('================');
  //       // StatusAlert.show(
  //       //   context,
  //       //   duration: Duration(seconds: 3),
  //       //   title: 'falle bro :(',
  //       //   subtitle: '${error.toString()}',
  //       //   configuration: IconConfiguration(icon: Icons.warning),
  //       // );

  //       final e = error.toString();

  //       //Lo debes controlar en la vista
  //     },
  //     cancelOnError: false,
  //      onDone: () {
  //       print("Hola mundo");
  //     });
  // }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    // blocG = bloc;
    // startStream(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Ingresar', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          //  Text('¿Olvido la contraseña?'),
          //  SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(
                value), //mandarle los datos del block atraves del provider viene del export
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                // counterText: snapshot.data,//para que vean los datos en consola
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //se recibe el bloc
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                //bordes del boton
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(context, bloc) : null);
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    try {
      bloc.loginUser(emailf: bloc.email, pwsf: bloc.password);
      //print("hola no entre");
      bloc.login.listen((event) {
        print(event);
        if (event.containsKey("token")) {
          Navigator.pushReplacementNamed(context, 'home', arguments: event);
        } else {
          StatusAlert.show(
            context,
            duration: Duration(seconds: 3),
            title: 'error',
            subtitle: '${event["mensaje"]}',
            configuration: IconConfiguration(icon: Icons.warning),
          );
        }
      });
      // StreamBuilder(
      //   stream: bloc.login,
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasData) {
      //       print(snapshot.data);
      //       if (snapshot.data["status"]) {
      //         Navigator.pushReplacementNamed(context, 'home');
      //       } else {
      //         StatusAlert.show(
      //           context,
      //           duration: Duration(seconds: 3),
      //           title: 'error',
      //           subtitle: '${snapshot.data["mensaje"]}',
      //           configuration: IconConfiguration(icon: Icons.warning),
      //         );
      //       }
      //     } else if (snapshot.hasError) {
      //       StatusAlert.show(
      //         context,
      //         duration: Duration(seconds: 3),
      //         title: 'falle bro :(',
      //         subtitle: '${snapshot.error.toString()}',
      //         configuration: IconConfiguration(icon: Icons.warning),
      //       );
      //     }
      //     return Container();
      //   },
      // );
    } catch (e) {
      print("error: " + e.toString());

      // StatusAlert.show(
      //   context,
      //   duration: Duration(seconds: 3),
      //   title: 'falle bro :(',
      //   subtitle: '${e.toString()}',
      //   configuration: IconConfiguration(icon: Icons.warning),
      // );
      print('================');
      print(
          'Email: ${bloc.email}'); //es por esta funcion:  String get password =>
      print('Password: ${bloc.password}');
      print('================');
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.car_rental, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Tickets',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
