import 'package:flutter/material.dart';
import 'package:webhoper_test/page/home_page/home_view.dart';
import 'package:webhoper_test/page/login/login_view.dart';
import 'package:webhoper_test/page/splash.dart';

// This class is using for set route
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    debugPrint(settings.name.toString());
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute<void>(builder: (_) => const SplashPage());

      case '/LoginView':
        return LoginView.route();

      case '/HomeView':
        return HomeView.route();


      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Center(child: Text('Route Error')))));
    }
  }
}
