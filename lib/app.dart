import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webhoper_test/help/app_config.dart' as config;
import 'package:webhoper_test/page/login/cubit/login_cubit.dart';
import 'package:webhoper_test/repos/authentication_repository.dart';
import 'package:webhoper_test/repos/user_repository.dart';
import 'package:webhoper_test/route_generator.dart';

import 'bloc/authentication/authentication_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository? authenticationRepository;
  final UserRepository? userRepository;

  const App({Key? key, this.authenticationRepository, this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authenticationRepository),
        RepositoryProvider(create: (context) => userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository!,
              userRepository: userRepository!,
            ),
          ),
          BlocProvider(
            create: (_) => LoginCubit(
              authenticationRepository: authenticationRepository!,
              userRepository: userRepository!,
            ),
          ),
        ],
        child: AppView(
          userRepository: userRepository,
        ),
      ),
    );
  }
}

// After main class this class is calling
class AppView extends StatefulWidget {
  const AppView({Key? key, this.userRepository}) : super(key: key);

  final UserRepository? userRepository;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState? get _navigator => navigatorKey.currentState;

  // This method calling first time in the app
  @override
  void initState() {
    super.initState();

    // To change the status bar and navigation bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));

    // Set the orientation of the app
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) async {
                switch (state.status) {
                  // Check enum status if user login then calling (authenticated) otherwise (unauthenticated)
                  case AuthenticationStatus.authenticated:
                    // Calling Dashboard Page which page pass in the RouteGenerator class

                    _navigator!
                        .pushNamedAndRemoveUntil('/HomeView', (route) => false);

                    break;

                  case AuthenticationStatus.unauthenticated:
                    debugPrint('app:-unauthenticated');
                    // Calling Login Page which page pass in the RouteGenerator class

                    _navigator!.pushNamedAndRemoveUntil(
                      '/LoginView',
                      (route) => false,
                    );

                    break;
                  default:
                    break;
                }
              },
              child: child,
            ));
      },
      initialRoute: '/Splash',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        fontFamily: 'poppins',
        primaryColor: config.AppColors().colorPrimary(1),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: config.AppColors().accentColor(0.1),
        unselectedWidgetColor: Colors.black,
        canvasColor: config.AppColors().colorPrimary(1),
      ),
    );
  }
}
