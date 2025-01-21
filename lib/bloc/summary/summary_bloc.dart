import 'package:app_chess/services/model/summary_response.dart';
import 'package:app_chess/services/service.dart';

import 'summary_export.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final DioService _dioService;

  SummaryBloc({required DioService dioService})
      : _dioService = dioService,
        super(const SummaryInitial()) {
    on<FetchSummary>(_onFetchSummary);
    on<FetchReset>(_onFetchReset);
  }

  Future<void> _onFetchSummary(
    FetchSummary event,
    Emitter<SummaryState> emit,
  ) async {
    emit(SummaryLoading());
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'summary?date_from=${event.dateFrom}&date_to=${event.dateTo}',
      );

      if (response.data['success'] == true) {
        final summaryResponse = SummaryResponse.fromJson(response.data);

        final summaryModel = summaryResponse.summaryModel;

        print('Lấy tổng hợp thành công: ${summaryResponse.message}');
        emit(SummaryLoaded(summaryModel));
      } else {
        // Đăng nhập thất bại

        emit(SummaryError('Error API ${response.data['message']}'));
      }
    } catch (error) {
      // print('Error $error');

      emit(SummaryError('Error $error'));
    }
  }

  Future<void> _onFetchReset(
    FetchReset event,
    Emitter<SummaryState> emit,
  ) async {
    emit(SummaryLoading());
    try {
      DioService apiService = DioService();
      final response = await apiService.post(
        'reset-data',
      );

      if (response.data['success'] == true) {
        emit(SummaryResetDone());
      } else {
        // Đăng nhập thất bại

        emit(SummaryError('Error API ${response.data['message']}'));
      }
    } catch (error) {
      // print('Error $error');

      emit(SummaryError('Error $error'));
    }
  }
}
