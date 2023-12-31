import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:webhoper_test/help/app_config.dart';
import 'package:webhoper_test/help/helper.dart';
import 'package:webhoper_test/page/login/cubit/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginView());
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.addListener(() {
      context
          .read<LoginCubit>()
          .onEmailChange(email: emailController.text.trim().toString());
    });

    passwordController.addListener(() {
      context.read<LoginCubit>().onPasswordChanged(
          password: passwordController.text.trim().toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(AppConfig(context).appWidth(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.jpeg'),

                SizedBox(
                  height: AppConfig(context).appHeight(2),
                ),

                TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConfig(context).appWidth(4.5)),
                  decoration: InputDecoration(
                    errorText: state.email!.invalid
                        ? 'Please enter valid email'
                        : null,
                    hintText: 'Enter email',
                    labelText: 'Email',
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: AppColors().colorPrimary(1),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                          width: AppConfig(context).appWidth(0.3),
                          color: AppColors().colorPrimary(1)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.all(AppConfig(context).appWidth(2)),
                    fillColor: Colors.transparent,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: AppConfig(context).appHeight(2),
                ),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: !state.passwordStatus!,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: AppConfig(context).appWidth(4.5)),
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    labelText: 'Password',
                    suffixIcon: InkWell(
                        onTap: () {
                          context.read<LoginCubit>().onVisiblePassword();
                        },
                        child: Icon(state.passwordStatus!
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    errorText: state.password!.invalid
                        ? 'Please enter valid password'
                        : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: AppColors().colorPrimary(1),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                          width: AppConfig(context).appWidth(0.3),
                          color: AppColors().colorPrimary(1)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.all(AppConfig(context).appWidth(2)),
                    fillColor: Colors.transparent,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                      borderSide: BorderSide(
                        width: AppConfig(context).appWidth(0.3),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(10),
                ),

                state.apiStatus!.isSubmissionInProgress?
                Helper.showLoader():
                InkWell(
                  onTap: () {
                    if (state.status!.isValidated) {
                      context.read<LoginCubit>().doLogin();
                    }
                  },
                  child: Container(
                    height: AppConfig(context).appHeight(6.0),
                    width: AppConfig(context).appWidth(80),
                    decoration: BoxDecoration(
                      color: state.status!.isValidated
                          ? AppColors().colorPrimary(1)
                          : Theme.of(context).focusColor,
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(1.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: AppConfig(context).appWidth(4.5),
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// https://reqres.in/api/login
//     {
// "email": "eve.holt@reqres.in",
// "password": "cityslicka"
// }
// https://reqres.in/api/unknown
