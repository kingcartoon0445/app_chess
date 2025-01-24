import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:app_chess/models/board.dart';
import 'package:app_chess/models/cell.dart';
import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/screens/login/login_page.dart';
import 'package:app_chess/services/dio_api.dart';
import 'package:app_chess/services/model/login_response.dart';
import 'package:app_chess/ui/cell_widget.dart';
import 'package:app_chess/ui/widget/dialog_common.dart';
import 'package:app_chess/util/global_data.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class BoardWidget extends StatefulWidget {
  final Board board;
  final Cell? selectedCell;
  final Set<String> availablePositionsHash;

  const BoardWidget(
      {Key? key,
      required this.board,
      required this.selectedCell,
      required this.availablePositionsHash})
      : super(key: key);

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  String _Pass = "";
  String _PassRan = "";
  String _deviceId = "";
  String _numericDeviceId = "";
  @override
  void initState() {
    _PassRan = prefs.getString(PrefsKey().passLogin);

    // TODO: implement initState
    super.initState();
  }

  final prefs = SharedPrefsService();
  DioService apiService = DioService();
  List<CellWidget> _buildCells(BuildContext context) {
    final List<CellWidget> cellWidgets = [];
    String check(String positionHash) {
      switch (positionHash) {
        case "0-3":
          return "1";
        case "1-3":
          return "2";
        case "2-3":
          return "3";
        case "3-3":
          return "4";
        case "4-3":
          return "5";
        case "1-4":
          return "6";
        case "2-4":
          return "7";
        case "3-4":
          return "8";
        case "4-4":
          return "9";
        case "5-4":
          return "0";
      }
      return "";
    }

    String _convertToFourDigitNumber(String deviceId) {
      final bytes =
          utf8.encode(deviceId); // Chuyển Device ID thành danh sách bytes
      final hash = bytes.fold<int>(
          0, (prev, element) => prev + element); // Tính tổng các byte
      final fourDigitNumber =
          hash.abs() % 10000; // Giới hạn kết quả trong khoảng 0 - 9999
      return fourDigitNumber.toString().padLeft(4, '0'); // Đảm bảo đủ 4 chữ số
    }

    Future<void> _getDeviceId() async {
      try {
        final deviceInfo = DeviceInfoPlugin();
        String deviceId;

        // Kiểm tra nền tảng thiết bị
        if (Theme.of(context).platform == TargetPlatform.android) {
          final androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id; // Android ID
        } else if (Theme.of(context).platform == TargetPlatform.iOS) {
          final iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor!; // IDFV
        } else {
          deviceId = "Unknown Device ID";
        }

        // Chuyển Device ID thành số 4 chữ số
        final numericDeviceId = _convertToFourDigitNumber(deviceId);
        if (_PassRan == "") {
          setState(() {
            _PassRan = _numericDeviceId;
          });
        }

        prefs.setString(PrefsKey().passLogin, _PassRan);
        DialogCommon().showSuccessDialog(context, message: _PassRan);
        setState(() {
          _deviceId = deviceId;
          _numericDeviceId = numericDeviceId;
        });
      } catch (e) {
        setState(() {
          _deviceId = "Lỗi khi lấy Device ID: $e";
        });
      }
    }

    _onLog() async {
      String token = prefs.getString(PrefsKey().token);
      apiService.setAuthToken(token);
      Map<String, dynamic>? business =
          await prefs.getMapFromSharedPreferences(PrefsKey().business);
      if (business != null) {
        GlobalData.instance.business = Business.fromJson(business);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                token == "" ? LoginPage() : FinancialSummaryScreen()),
      );
    }

    String createPass() {
      // Tạo một số ngẫu nhiên 4 chữ số
      int generateRandomFourDigit() {
        Random random = Random();
        return 1000 + random.nextInt(9000); // Số ngẫu nhiên từ 1000 đến 9999
      }

      // Gọi hàm và in kết quả
      int randomNumber = generateRandomFourDigit();
      print('Số ngẫu nhiên 4 chữ số: $randomNumber');
      return randomNumber.toString();
    }

    for (var cellList in widget.board.cells) {
      for (var cell in cellList) {
        cellWidgets.add(CellWidget(
          onTap: () {
            _Pass = _Pass + check(cell.positionHash);
            dev.log(_Pass);
            if (_Pass.length == 4) {
              if (_Pass == "0306") {
                _getDeviceId();
              } else {
                if (_Pass == _PassRan) {
                  _onLog();
                }
              }
              _Pass = "";
            }
          },
          cell: cell,
          isSelected:
              widget.selectedCell != null && widget.selectedCell! == cell,
          isAvailable:
              widget.availablePositionsHash.contains(cell.positionHash),
        ));
      }
    }

    return cellWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Colors.brown, width: 16),
        bottom: BorderSide(color: Colors.brown, width: 16),
      )),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: boardSize,
          children: _buildCells(context),
        ),
      ),
    );
  }
}
