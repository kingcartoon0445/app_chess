import 'dart:convert';
import 'dart:developer';

import 'package:app_chess/bloc/cubits/game_cubit.dart';
import 'package:app_chess/config/colors.dart';
import 'package:app_chess/models/cell.dart';
import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/screens/login/login_page.dart';
import 'package:app_chess/screens/login/login_screen.dart';
import 'package:app_chess/services/dio_api.dart';
import 'package:app_chess/services/model/login_response.dart';
import 'package:app_chess/ui/figure_widget.dart';
import 'package:app_chess/util/global_data.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

class CellWidget extends StatelessWidget {
  final Cell cell;
  final bool isSelected;
  final bool isAvailable;

  const CellWidget(
      {Key? key,
      required this.cell,
      required this.isSelected,
      required this.isAvailable})
      : super(key: key);

  _onTap(BuildContext context) async {
    final prefs = SharedPrefsService();
    DioService apiService = DioService();
    String token = prefs.getString(PrefsKey().token);
    apiService.setAuthToken(token);
    Map<String, dynamic>? business =
        await prefs.getMapFromSharedPreferences(PrefsKey().business);
    if (business != null) {
      GlobalData.instance.business = Business.fromJson(business);
    }
    log(token);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              token == "" ? LoginPage() : FinancialSummaryScreen()),
    );
    final gameCubit = GetIt.I<GameCubit>();

    // if AI calculating position => block any interactions
    if (gameCubit.state.isAIthinking) {
      return;
    }

    final activeColor = gameCubit.state.activeColor;

    if (isAvailable || (cell.occupied && isAvailable)) {
      gameCubit.moveFigure(cell);
      return;
    }

    if (cell.occupied && activeColor == cell.getFigure()!.color) {
      gameCubit.selectCell(cell);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Stack(
        children: [
          Container(
            color: cell.isBlack ? AppColors.black : AppColors.white,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: isSelected
                ? Colors.blueAccent.withOpacity(0.3)
                : Colors.transparent,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: isAvailable && cell.occupied
                ? Colors.redAccent.withOpacity(0.8)
                : Colors.transparent,
          ),
          Center(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isAvailable ? constraints.maxWidth * 0.2 : 0,
              height: isAvailable ? constraints.maxWidth * 0.2 : 0,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent.withOpacity(0.9),
                borderRadius: BorderRadius.circular(constraints.maxWidth),
              ),
            );
          })),
          if (cell.occupied) FigureWidget(figure: cell.getFigure()!),
          // Text(
          //   cell.positionHash,
          //   style: const TextStyle(color: Colors.red),
          // )
        ],
      ),
    );
  }
}
