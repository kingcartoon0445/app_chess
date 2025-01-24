import 'dart:developer';

import 'package:app_chess/util/global_data.dart';
import 'package:app_chess/util/global_event.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class WsConnector {
  static final WsConnector instance = WsConnector._privateConstructor();

  WsConnector._privateConstructor();
  late PusherChannelsFlutter pusher;

  Future<void> initWS(String apiKey, cluster) async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: apiKey,
      pongTimeout: 5000,
      cluster: cluster,
      onEvent: onEvent,
      onError: onError,
      onConnectionStateChange: onConnectionStateChange,
    );

    await pusher.connect();
    log("Connect ws key: $apiKey, cluster: $cluster");
  }

  Future<void> subChannel(String channelName) async {
    await pusher.subscribe(channelName: channelName);
  }

  void unSubChannel(String channelName) async {
    await pusher.unsubscribe(channelName: channelName);
  }

  void onEvent(PusherEvent event) {
    log("onEvent: $event");

    GlobalEvent.instance.onListenSocketCtrl.sink.add(event);
    //json.decode()
  }

  void onError(String message, int? code, dynamic error) {
    // logger.e(
    //     "onError: \n 1. msg: $message \n 2. code: $code \n 3. error: $error");
  }

  void onConnectionStateChange(
      String currentState, String previousState) async {
    if (currentState == "DISCONNECTED") {
      await pusher.connect();
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) async {
    log("onSubscriptionSucceeded: $channelName, data: $data");
  }

  void dispose() {
    GlobalEvent.instance.close();
    pusher.disconnect();
  }
}
