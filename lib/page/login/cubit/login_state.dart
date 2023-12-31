part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.passwordStatus = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.apiStatus = FormzStatus.pure,
  });

  final bool? passwordStatus;
  final FormzStatus? status;
  final FormzStatus? apiStatus;
  final Email? email;
  final Password? password;

  LoginState copyWith({
    bool? passwordStatus,
    Email? email,
    Password? password,
    FormzStatus? status,
    FormzStatus? apiStatus,
  }) {
    return LoginState(
      passwordStatus: passwordStatus ?? this.passwordStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props =>
      [passwordStatus, email, password, status, apiStatus];
}
