import 'package:app_chess/services/dio_api.dart';
import 'package:app_chess/services/model/device_response.dart';
import 'package:app_chess/services/model/device_update_response.dart';
import 'package:app_chess/services/model/login_response.dart';
import 'package:app_chess/services/model/summary_of_user_response.dart';
import 'package:app_chess/services/model/summary_response.dart';

// ignore: constant_identifier_names
enum StatusLogin { LOGINDON, LOGINERROR }

class ServiceApp {
  Future<StatusLogin?> login(String username, String password) async {
    try {
      DioService apiService = DioService();
      final response = await apiService.post(
        '/login',
        data: {"username": username, "password": password},
      );

      final loginResponse = LoginResponse.fromJson(response.data);

      if (loginResponse.success) {
        // Đăng nhập thành công
        final user = loginResponse.loginData!.user;
        final business = loginResponse.loginData!.business;

        // Lưu token
        apiService.setAuthToken(user.apiToken);
        print('Đăng nhập thành công: ${loginResponse.message}');
        return StatusLogin.LOGINDON;
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${loginResponse.message}');
        return StatusLogin.LOGINERROR;
      }
    } catch (error) {
      print('Lỗi: $error');
      return StatusLogin.LOGINERROR;
    }
  }

  Future<SummaryModel?> getSummary(String date_from, String date_to) async {
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        '/summary?date_from=$date_from&date_to=$date_to',
      );

      final summaryResponse = SummaryResponse.fromJson(response.data);

      if (summaryResponse.success!) {
        // Đăng nhập thành công
        final summaryModel = summaryResponse.summaryModel;
        // final business = summaryResponse.summaryModel!.business;

        // Lưu token
        // apiService.setAuthToken(user.apiToken);
        print('Đăng nhập thành công: ${summaryResponse.message}');
        return summaryModel;
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${summaryResponse.message}');
        return null;
      }
    } catch (error) {
      print('Lỗi: $error');
      return null;
    }
  }

  // ignore: non_constant_identifier_names
  Future<SummaryOfUserModel?> getSummaryByUser(
      {required String user,
      // ignore: non_constant_identifier_names
      required String date_from,
      // ignore: non_constant_identifier_names
      required String date_to}) async {
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'summary-by-user?user=$user&date_from=$date_from&date_to=$date_to',
      );

      final summaryOfUserResponse =
          SummaryOfUserResponse.fromJson(response.data);

      if (summaryOfUserResponse.success!) {
        // Đăng nhập thành công
        SummaryOfUserModel? summaryOfUserModel =
            summaryOfUserResponse.summaryOfUserModel;

        // Lưu token

        print('Đăng nhập thành công: ${summaryOfUserResponse.message}');
        return summaryOfUserModel;
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${summaryOfUserResponse.message}');
        return null;
      }
    } catch (error) {
      print('Lỗi: $error');
      return null;
    }
  }

  Future<List<DeviceModel>?> getDevice() async {
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'device',
      );

      final deviceResponse = DeviceResponse.fromJson(response.data);

      if (deviceResponse.success!) {
        // Đăng nhập thành công

        List<DeviceModel>? deviceModeles = deviceResponse.deviceModeles!;

        // Lưu token
        print('Đăng nhập thành công: ${deviceResponse.message}');
        return deviceModeles;
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${deviceResponse.message}');
        return null;
      }
    } catch (error) {
      print('Lỗi: $error');
      return null;
    }
  }

  Future<DeviceUpdateModel?> updateDevice({
    required String idDevice,
    // ignore: non_constant_identifier_names
    required String active,
  }) async {
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'device/$idDevice?active=$active',
      );

      final deviceUpdateResponse = DeviceUpdateResponse.fromJson(response.data);

      if (deviceUpdateResponse.success!) {
        // Đăng nhập thành công
        final deviceUpdateModel = deviceUpdateResponse.deviceUpdateModel!;

        // Lưu token
        print('Đăng nhập thành công: ${deviceUpdateResponse.message}');
        return deviceUpdateModel;
      } else {
        // Đăng nhập thất bại
        print('Đăng nhập thất bại: ${deviceUpdateResponse.message}');
        return null;
      }
    } catch (error) {
      print('Lỗi: $error');
      return null;
    }
  }
}
