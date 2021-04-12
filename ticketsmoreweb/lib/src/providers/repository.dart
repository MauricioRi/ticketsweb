import '../models/user.model.dart';
import 'package:flutter/foundation.dart';
import 'user.provider.dart';

class Repository {
  final userProvider = UserProvider();

  Future<Map<String, dynamic>> login(
          {@required String email, @required String pws}) =>
      userProvider.login(email: email, pws: pws);
}
