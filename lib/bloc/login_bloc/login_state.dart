import 'package:app_chess/services/model/login_response.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginLoaded extends LoginState {
  final LoginData? loginData;
  const LoginLoaded(this.loginData);
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}
