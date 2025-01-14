import 'package:app_chess/bloc/cubits/game_cubit.dart';
import 'package:app_chess/bloc/cubits/settings_cubit.dart';
import 'package:get_it/get_it.dart';

createAppBlocs() {
  GetIt.I.registerSingleton<GameCubit>(GameCubit.initial());
  GetIt.I.registerSingleton<SettingsCubit>(SettingsCubit.initial());
}
