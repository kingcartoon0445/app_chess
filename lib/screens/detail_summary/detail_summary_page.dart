import 'package:app_chess/screens/login/login_page.dart';
import 'package:app_chess/services/model/summary_of_user_response.dart';
import 'package:app_chess/ui/loading_common.dart';
import 'package:app_chess/ui/widget/dialog_common.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../bloc/detail_summer/detail_summer_export.dart';
import 'detail_summary_screen.dart';

// ignore: must_be_immutable
class DetailSummaryPage extends StatelessWidget {
  String user;
  String date_from;
  String date_to;
  DetailSummaryPage(
      {super.key,
      required this.user,
      required this.date_from,
      required this.date_to});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailSummaryBloc(
        dioService: DioService(),
      ),
      child: DetailSummaryView(
        user: user,
        date_from: date_from,
        date_to: date_to,
      ),
    );
  }
}

class DetailSummaryView extends StatefulWidget {
  String user;
  String date_from;
  String date_to;
  DetailSummaryView(
      {super.key,
      required this.user,
      required this.date_from,
      required this.date_to});

  @override
  State<DetailSummaryView> createState() => _DetailSummaryViewState();
}

class _DetailSummaryViewState extends State<DetailSummaryView> {
  @override
  void initState() {
    context.read<DetailSummaryBloc>().add(
          FetchDetailSummer(
              user: widget.user,
              date_from: widget.date_from,
              date_to: widget.date_to),
        );
    super.initState();
  }

  DetailSummaryModel? detailSummaryModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailSummaryBloc, DetailSummaryState>(
      listener: (context, state) {
        if (state is DetailSummaryLoading) {
          LoadingDialog.show(
            context,
            customLoadingWidget: CustomLoadingWidget(
              // color: Colors.red,
              size: 40,
            ),
            message: 'loading'.tr(),
          );
        }

        if (state is DetailSummaryError) {
          LoadingDialog.hide(context);
          if (state.message == 'Unauthenticated.') {
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

        if (state is DetailSummaryLoaded) {
          LoadingDialog.hide(context);
          setState(() {
            detailSummaryModel = state.detailSummaryModel;
          });
          // return FinancialDetailSummaryScreen();
        }
      },
      child: DetailSummaryScreen(
        detailSummaryModel: detailSummaryModel,
      ),
    );
  }
}
