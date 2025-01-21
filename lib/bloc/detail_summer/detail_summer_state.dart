import 'package:app_chess/services/model/device_response.dart';
import 'package:app_chess/services/model/summary_of_user_response.dart';

abstract class DetailSummaryState {
  const DetailSummaryState();
}

class DetailSummaryInitial extends DetailSummaryState {
  const DetailSummaryInitial();
}

class DetailSummaryLoading extends DetailSummaryState {
  const DetailSummaryLoading();
}

class DetailSummaryLoaded extends DetailSummaryState {
  final DetailSummaryModel? detailSummaryModel;
  const DetailSummaryLoaded(this.detailSummaryModel);
}

class DetailSummaryError extends DetailSummaryState {
  final String message;
  const DetailSummaryError(this.message);
}
