import 'package:app_chess/services/model/summary_response.dart';

abstract class SummaryState {
  const SummaryState();
}

class SummaryInitial extends SummaryState {
  const SummaryInitial();
}

class SummaryLoading extends SummaryState {
  const SummaryLoading();
}

class SummaryResetDone extends SummaryState {
  const SummaryResetDone();
}

class SummaryLoaded extends SummaryState {
  final SummaryModel? summaryModel;
  const SummaryLoaded(this.summaryModel);
}

class SummaryError extends SummaryState {
  final String message;
  const SummaryError(this.message);
}
