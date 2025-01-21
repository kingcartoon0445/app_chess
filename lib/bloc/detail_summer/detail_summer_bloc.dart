import 'package:app_chess/services/model/summary_of_user_response.dart';

import 'detail_summer_export.dart';

class DetailSummaryBloc extends Bloc<DetailSummerEvent, DetailSummaryState> {
  final DioService _dioService;

  DetailSummaryBloc({required DioService dioService})
      : _dioService = dioService,
        super(const DetailSummaryInitial()) {
    on<FetchDetailSummer>(_onFetchDetailSummary);
  }

  Future<void> _onFetchDetailSummary(
    FetchDetailSummer event,
    Emitter<DetailSummaryState> emit,
  ) async {
    emit(DetailSummaryLoading());
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'summary-by-user?user=${event.user}&date_from=${event.date_from}&date_to=${event.date_to}',
      );

      if (response.data['success'] == true) {
        final summaryResponse = DetailSummaryResponse.fromJson(response.data);

        final detailSummaryModel = summaryResponse.summaryOfUserModel;

        print('Lấy tổng hợp thành công: ${summaryResponse.message}');
        emit(DetailSummaryLoaded(detailSummaryModel));
      } else {
        // Đăng nhập thất bại

        emit(DetailSummaryError('Error API ${response.data['message']}'));
      }
    } catch (error) {
      // print('Error $error');

      emit(DetailSummaryError('Error $error'));
    }
  }
}
