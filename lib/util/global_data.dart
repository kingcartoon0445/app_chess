import 'dart:ui';

import 'package:app_chess/bloc/detail_summer/detail_summer_export.dart';
import 'package:app_chess/services/model/login_response.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationList {
  String tiengViet = 'vi';
  String tiengAnh = 'en';
  String tiengDuc = 'de';
}

class GlobalData {
  GlobalData._privateConstructor();

  static final GlobalData instance = GlobalData._privateConstructor();

  User? user;
  Business? business;

  void clearData() {
    user = null;
    business = null;
  }

  void changeLocation(BuildContext context, String location) {
    context.setLocale(Locale(location));
  }
}
