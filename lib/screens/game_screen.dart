import 'package:app_chess/bloc/cubits/game_cubit.dart';
import 'package:app_chess/bloc/states/game_state.dart';
import 'package:app_chess/config/colors.dart';
import 'package:app_chess/ui/board_widget.dart';
import 'package:app_chess/ui/dropdown_language.dart';
import 'package:app_chess/ui/lost_figures_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<GameCubit, GameState>(
        bloc: GetIt.I<GameCubit>(),
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LanguageDropdown(),
              LostFiguresWidget(figures: state.board.blackLost.figures),
              BoardWidget(
                availablePositionsHash: state.availablePositionsHash,
                board: state.board,
                selectedCell: state.selectedCell,
              ),
              LostFiguresWidget(figures: state.board.whiteLost.figures),
            ],
          );
        },
      ),
    );
  }
}
