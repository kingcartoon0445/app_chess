import 'package:app_chess/services/model/device_response.dart';

abstract class DeviceState {
  const DeviceState();
}

class DeviceInitial extends DeviceState {
  const DeviceInitial();
}

class DeviceLoading extends DeviceState {
  const DeviceLoading();
}

class DeviceUpdateDone extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final List<DeviceModel>? deviceModeles;
  const DeviceLoaded(this.deviceModeles);
}

class DeviceError extends DeviceState {
  final String message;
  const DeviceError(this.message);
}
