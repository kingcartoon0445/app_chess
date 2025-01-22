import 'package:app_chess/bloc/summary/summary_export.dart';
import 'package:app_chess/screens/financial_summary/financial_summary_screen.dart';
import 'package:app_chess/screens/financial_summary/summary_page.dart';
import 'package:app_chess/ui/loading_common.dart';
import 'package:app_chess/ui/widget/dialog_common.dart';
import 'package:app_chess/util/global_data.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../bloc/login_bloc/login_export.dart';
import 'login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        dioService: DioService(),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          LoadingDialog.show(
            context,
            customLoadingWidget: CustomLoadingWidget(
              // color: Colors.red,
              size: 40,
            ),
            message: 'loading'.tr(),
          );
        }

        if (state is LoginError) {
          LoadingDialog.hide(context);
          if (state.message == 'Unauthenticated.' ||
              state.message == 'Error API Unauthenticated') {
            final prefs = SharedPrefsService();
            prefs.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (Route<dynamic> route) => true,
            );
            DialogCommon()
                .showErrorDialog(context, message: 'unauthenticated'.tr());
          } else {
            DialogCommon()
                .showErrorDialog(context, message: 'Error: ${state.message}');
          }
        }

        if (state is LoginLoaded) {
          GlobalData.instance.user = state.loginData!.user;
          GlobalData.instance.business =
              state.loginData!.business; //  lưu GlobalData
          LoadingDialog.hide(context);
          // return FinancialLoginScreen();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FinancialSummaryScreen(),
            ),
            (Route<dynamic> route) => true,
          );
        }
      },
      child: LoginScreen(
        onLogin: (userName, passwold, saveToken) {
          context.read<LoginBloc>().add(
                FetchLogin(
                  saveToken: saveToken,
                  // token: 'your_token_here',
                  username: userName,
                  password: passwold,
                ),
              );
        },
      ),
    );
  }
}
