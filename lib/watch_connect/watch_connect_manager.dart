import 'package:daily_dogs/util/huh.dart';
import 'package:daily_dogs/watch_connect/watch_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class WatchConnectManager {
  WatchConnectManager({this.onReachableStateChanged});

  final _watch = WatchConnectivity();

  WatchConfiguration? configuration;
  final ValueChanged<bool>? onReachableStateChanged;

  void initConfigurations() async {
    configuration = await _watch.initConfiguration();
    onReachableStateChanged?.call(configuration?.isReachable ?? false);
  }

  void sendMessage(JsonMap message) {
    _watch.sendMessage(message);
  }
}
