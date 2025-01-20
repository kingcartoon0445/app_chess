import 'package:app_chess/services/model/login_response.dart';
import 'package:app_chess/services/service.dart';

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
        print('Đăng nhập thành công: ${loginResponse.message}');
        emit(LoginLoaded(loginResponse.loginData!));
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${response.data['message']}');
        // return StatusLogin.LOGINERROR;
        emit(LoginError("Đăng nhập thất bại: ${response.data['message']}"));
      }
    } catch (error) {
      print('Lỗi: $error');

      emit(LoginError("Lỗi: $error"));
    }
  }
}
