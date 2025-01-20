abstract class LoginEvent {
  const LoginEvent();
}

class FetchLogin extends LoginEvent {
  final String username;
  final String password;

  const FetchLogin({
    required this.username,
    required this.password,
  });
}
