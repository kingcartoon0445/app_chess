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

class CellWidget extends StatefulWidget {
  final Cell cell;
  final bool isSelected;
  final bool isAvailable;
  Function()? onTap;
  CellWidget(
      {Key? key,
      required this.cell,
      required this.isSelected,
      required this.isAvailable,
      required this.onTap})
      : super(key: key);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  _onTap(BuildContext context) async {
    widget.onTap!();
    final gameCubit = GetIt.I<GameCubit>();

    // if AI calculating position => block any interactions
    if (gameCubit.state.isAIthinking) {
      return;
    }

    final activeColor = gameCubit.state.activeColor;

    if (widget.isAvailable || (widget.cell.occupied && widget.isAvailable)) {
      gameCubit.moveFigure(widget.cell);
      return;
    }

    if (widget.cell.occupied && activeColor == widget.cell.getFigure()!.color) {
      gameCubit.selectCell(widget.cell);
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
            color: widget.cell.isBlack ? AppColors.black : AppColors.white,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: widget.isSelected
                ? Colors.blueAccent.withOpacity(0.3)
                : Colors.transparent,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: widget.isAvailable && widget.cell.occupied
                ? Colors.redAccent.withOpacity(0.8)
                : Colors.transparent,
          ),
          Center(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: widget.isAvailable ? constraints.maxWidth * 0.2 : 0,
              height: widget.isAvailable ? constraints.maxWidth * 0.2 : 0,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent.withOpacity(0.9),
                borderRadius: BorderRadius.circular(constraints.maxWidth),
              ),
            );
          })),
          if (widget.cell.occupied)
            FigureWidget(figure: widget.cell.getFigure()!),
          // Text(
          //   widget.cell.positionHash,
          //   style: const TextStyle(color: Colors.red),
          // )
        ],
      ),
    );
  }
}
