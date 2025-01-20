abstract class DeviceEvent {
  const DeviceEvent();
}

class FetchDevice extends DeviceEvent {}

class FetchChangeStatusDevice extends DeviceEvent {
  String id;
  int value;
  FetchChangeStatusDevice({required this.id, required this.value});
}
