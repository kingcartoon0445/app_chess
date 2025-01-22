import 'dart:async';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class GlobalEvent {
  GlobalEvent._privateConstructor();

  static final GlobalEvent instance = GlobalEvent._privateConstructor();

  // ignore: close_sinks
  final onListenSocketCtrl = StreamController<PusherEvent>.broadcast();

  void close() {
    onListenSocketCtrl.close();
  }
}
