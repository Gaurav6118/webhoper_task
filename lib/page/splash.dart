import 'package:flutter/material.dart';
import 'package:webhoper_test/help/app_config.dart' as config;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                height: config.AppConfig(context).appHeight(40),
                width: config.AppConfig(context).appWidth(80),
                child: Image.asset(
                  'assets/webhoper_splash.png',
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
