import 'dart:developer';

import 'package:app_chess/services/model/login_response.dart';
import 'package:app_chess/services/service.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';

import 'login_export.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DioService _dioService;

  LoginBloc({required DioService dioService})
      : _dioService = dioService,
        super(const LoginInitial()) {
    on<FetchLogin>(_onFetchLogin);
  }

  Future<void> _onFetchLogin(
    FetchLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final prefs = SharedPrefsService();
      DioService apiService = DioService();
      final response = await apiService.post(
        'login',
        data: {"username": event.username, "password": event.password},
      );

      if (response.data['success']) {
        // Đăng nhập thành công

        final loginResponse = LoginResponse.fromJson(response.data);
        final user = loginResponse.loginData!.user;

        // Lưu token
        apiService.setAuthToken(user.apiToken);
        // event.saveTok  en
        if (event.saveToken) {
          await prefs.setString(PrefsKey().token, user.apiToken);
          await prefs.saveMapToSharedPreferences(
              PrefsKey().business, loginResponse.loginData!.business.toJson());
        }
        print('Đăng nhập thành công: ${loginResponse.message}');
        emit(LoginLoaded(loginResponse.loginData!));
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: Error API ${response.data['message']}');
        // return StatusLogin.LOGINERROR;
        emit(LoginError(
            "Đăng nhập thất bại: Error API ${response.data['message']}"));
      }
    } catch (error) {
      print('Error $error');

      emit(LoginError("Error $error"));
    }
  }
}
