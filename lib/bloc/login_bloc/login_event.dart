abstract class LoginEvent {
  const LoginEvent();
}

class FetchLogin extends LoginEvent {
  final bool saveToken;
  final String username;
  final String password;

  const FetchLogin({
    required this.saveToken,
    required this.username,
    required this.password,
  });
}
