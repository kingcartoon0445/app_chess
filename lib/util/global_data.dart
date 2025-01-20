import 'package:app_chess/services/model/login_response.dart';

class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();

  User? user;
  Business? business;

  void clearData() {
    user = null;
    business = null;
  }
}
