import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:webhoper_test/help/helper.dart';
import 'package:webhoper_test/model/email.dart';
import 'package:webhoper_test/model/password.dart';
import 'package:webhoper_test/model/user_model.dart';
import 'package:webhoper_test/repos/authentication_repository.dart';
import 'package:webhoper_test/repos/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({this.authenticationRepository, this.userRepository})
      : super(const LoginState());

  AuthenticationRepository? authenticationRepository;
  UserRepository? userRepository;

  onEmailChange({String? email}) {
    emit(state.copyWith(
        email: Email.dirty(email.toString()),
        status: Formz.validate([
          Email.dirty(email.toString()),
          state.password!,
        ])));
  }

  void onPasswordChanged({String? password}) {
    emit(state.copyWith(
        password: Password.dirty(password.toString()),
        status: Formz.validate([
          Password.dirty(password.toString()),
          state.email!,
        ])));
  }

  onVisiblePassword() {
    emit(state.copyWith(passwordStatus: !state.passwordStatus!));
  }

  void doLogin() async {
    try {
      emit(state.copyWith(apiStatus: FormzStatus.submissionInProgress));
      var map = {};
      map['email'] = state.email!.value.toString();
      map['password'] = state.password!.value.toString();

      debugPrint(map.toString());

      http.Response response = await userRepository!.logIn(data: map);

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonDecode(response.body));

        if (userModel.token!.isNotEmpty) {
          User newUser = User(email: state.email!.value.toString());

          UserModel user = UserModel(token: userModel.token, user: newUser);

          userRepository!.setCurrentUser(user).then((value) async {
            authenticationRepository!.controller
                .add(AuthenticationStatus.authenticated);
            emit(state.copyWith(apiStatus: FormzStatus.submissionSuccess));
            Helper.showToast('Login Successfully');
          });
        } else {
          emit(state.copyWith(apiStatus: FormzStatus.submissionFailure));
        }
      } else {
        emit(state.copyWith(apiStatus: FormzStatus.submissionFailure));
        Helper.showToast('User not found');
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(apiStatus: FormzStatus.submissionFailure));
    }
  }
}
