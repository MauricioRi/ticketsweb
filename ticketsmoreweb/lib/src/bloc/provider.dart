import 'package:flutter/material.dart';
import 'package:ticketsmoreweb/src/bloc/login_bloc.dart';
export 'package:ticketsmoreweb/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  //investigar como funciona el ingereted widget
//https://www.youtube.com/watch?v=ml5uefGgkaA&ab_channel=GoogleDevelopers
//https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      //esto es para cuando se ejecute un hot reload no se pierdan los datos del stream
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child})
      : super(key: key, child: child); //los datos que se le mandan al provider

  final loginBloc = LoginBloc();

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .loginBloc;
  }
}
