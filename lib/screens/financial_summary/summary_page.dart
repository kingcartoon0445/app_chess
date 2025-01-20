import 'package:app_chess/bloc/summary/summary_export.dart';
import 'package:app_chess/services/model/summary_response.dart';
import 'package:app_chess/ui/loading_common.dart';
import 'package:app_chess/ui/widget/dialog_common.dart';
import 'package:intl/intl.dart';

import 'financial_summary_screen.dart';
import 'widget/financial_one.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryBloc(
        dioService: DioService(),
      ),
      child: const SummaryView(),
    );
  }
}

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

final DateFormat formatter = DateFormat('dd.MM.yyyy');
SummaryModel? summaryModel;

class _SummaryViewState extends State<SummaryView> {
  @override
  void initState() {
    super.initState();
    context.read<SummaryBloc>().add(
          FetchSummary(
            dateFrom: formatter.format(DateTime.now()),
            dateTo: formatter.format(DateTime.now()),
          ),
        );
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SummaryBloc, SummaryState>(
      listener: (context, state) {
        if (state is SummaryLoading) {
          LoadingDialog.show(
            context,
            message: 'Đang tải dữ liệu...',
          );
        }
        if (state is SummaryResetDone) {
          setState(() {
            isLoading = false;
          });
          context.read<SummaryBloc>().add(
                FetchSummary(
                  dateFrom: formatter.format(DateTime.now()),
                  dateTo: formatter.format(DateTime.now()),
                ),
              );
        }
        if (state is SummaryError) {
          LoadingDialog.hide(context);
          DialogCommon()
              .showErrorDialog(context, message: 'Error: ${state.message}');
        }

        if (state is SummaryLoaded) {
          LoadingDialog.hide(context);
          setState(() {
            summaryModel = state.summaryModel;
          });
        }
      },
      child: FinancialOneScreen(
        summaryModel: summaryModel,
      ),
    );
  }
}
