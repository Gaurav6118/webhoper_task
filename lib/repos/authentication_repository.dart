import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:webhoper_test/repos/user_repository.dart';

// Set enum variable for check status
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

final navigatorKey = GlobalKey<NavigatorState>();

// This class is is used for Authentication
class AuthenticationRepository {
  final controller = StreamController<AuthenticationStatus>();
  final UserRepository _userRepository = UserRepository();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 5));
    final user = await _userRepository.getUser();
    if (user != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield * controller.stream;
  }


  // This function call for logout
  void logOut() async {
    _userRepository.clearUserData();
    controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => controller.close();
}
