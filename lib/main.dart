import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webhoper_test/repos/authentication_repository.dart';
import 'package:webhoper_test/repos/user_repository.dart';

import 'app.dart';

// This is a main method call App class
void main() async {

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(App(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ));
  }, (error, stack) {
    debugPrint("error $error",);
  });
}