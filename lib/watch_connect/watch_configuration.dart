import 'package:watch_connectivity/watch_connectivity.dart';

class WatchConfiguration {
  WatchConfiguration({
    required bool supported,
    required bool paired,
    required bool reachable,
  }) {
    _supported = supported;
    _paired = paired;
    _reachable = reachable;
  }

  var _supported = false;
  var _paired = false;
  var _reachable = false;

  bool get isSupported => _supported;

  bool get isPaired => _paired;

  bool get isReachable => _reachable;
}

extension ConfigurationExt on WatchConnectivity {
  Future<WatchConfiguration> initConfiguration() async {
    final supported = await isSupported;
    final paired = await isPaired;
    final reachable = await isReachable;
    return WatchConfiguration(
      supported: supported,
      paired: paired,
      reachable: reachable,
    );
  }
}
