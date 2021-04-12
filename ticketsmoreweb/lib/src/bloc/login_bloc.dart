import 'dart:async';
import 'package:ticketsmoreweb/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import '../providers/repository.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController
      .value; //esta funcion ya la traen los BehaviorSubject a diferencia de los stram

  final _repository = Repository();
  final _loginFetcher = PublishSubject<Map<String, dynamic>>();

  Stream<Map<String, dynamic>> get login => _loginFetcher.stream;

  loginUser({emailf, pwsf}) async {
    Map<String, dynamic> loginStatus =
        await _repository.login(email: emailf, pws: pwsf);
    _loginFetcher.sink.add(loginStatus);
    //para añadir informacion al stream se usa el sink y para obtener la informacion se usa el stream
  }

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _loginFetcher?.close();
  }
}
