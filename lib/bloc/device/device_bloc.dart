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

      if (response.data['success']!) {
        final summaryResponse = DeviceResponse.fromJson(response.data);

        final deviceModeles = summaryResponse.deviceModeles;

        print('Lấy tổng hợp thành công: ${summaryResponse.message}');
        emit(DeviceLoaded(deviceModeles));
      } else {
        // Đăng nhập thất bại

        emit(DeviceError('Error API ${response.data['message']}'));
      }
    } catch (error) {
      // print('Error $error');

      emit(DeviceError('Error $error'));
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

        emit(DeviceError('Error API ${response.data['message']}'));
      }
    } catch (error) {
      // print('Error $error');

      emit(DeviceError('Error $error'));
    }
  }
}
