import 'package:app_chess/services/model/device_response.dart';
import 'package:app_chess/services/model/device_update_response.dart';

import 'device_export.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DioService _dioService;

  DeviceBloc({required DioService dioService})
      : _dioService = dioService,
        super(const DeviceInitial()) {
    on<FetchDevice>(_onFetchDevice);
    on<FetchChangeStatusDevice>(_onFetchChangeStatusDevice);
  }

  Future<void> _onFetchDevice(
    FetchDevice event,
    Emitter<DeviceState> emit,
  ) async {
    emit(DeviceLoading());
    try {
      DioService apiService = DioService();
      final response = await apiService.get(
        'device',
      );

      final summaryResponse = DeviceResponse.fromJson(response.data);

      if (summaryResponse.success!) {
        final deviceModeles = summaryResponse.deviceModeles;

        print('Lấy tổng hợp thành công: ${summaryResponse.message}');
        emit(DeviceLoaded(deviceModeles));
      } else {
        // Đăng nhập thất bại

        emit(DeviceError('Lấy tổng hợp bại: ${summaryResponse.message}'));
      }
    } catch (error) {
      // print('Lỗi: $error');

      emit(DeviceError('Lỗi: $error'));
    }
  }

  Future<void> _onFetchChangeStatusDevice(
    FetchChangeStatusDevice event,
    Emitter<DeviceState> emit,
  ) async {
    emit(DeviceLoading());
    try {
      DioService apiService = DioService();
      final response = await apiService.put(
        'device/${event.id}?active=${event.value}',
      );

      if (response.data['success'] == true) {
        final summaryResponse = DeviceUpdateResponse.fromJson(response.data);

        print('Lấy tổng hợp thành công: ${summaryResponse.message}');

        emit(DeviceUpdateDone());
      } else {
        // Đăng nhập thất bại

        emit(DeviceError('Lấy tổng hợp bại: ${response.data['message']}'));
      }
    } catch (error) {
      // print('Lỗi: $error');

      emit(DeviceError('Lỗi: $error'));
    }
  }
}
