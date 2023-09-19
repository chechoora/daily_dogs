import 'package:watch_connectivity/watch_connectivity.dart';

class WatchConnectManager {
  final _watch = WatchConnectivity();

  var _supported = false;
  var _paired = false;
  var _reachable = false;
  var _context = <String, dynamic>{};
  var _receivedContexts = <Map<String, dynamic>>[];

  void init() {
    _watch.messageStream.listen((data) {
      print('test');
    });

    _watch.contextStream.listen((data) {
      print('test');
    });

    initConfigurations();
  }

  void initConfigurations() async {
    _supported = await _watch.isSupported;
    _paired = await _watch.isPaired;
    _reachable = await _watch.isReachable;
    _context = await _watch.applicationContext;
    _receivedContexts = await _watch.receivedApplicationContexts;
    print('test');
  }

  void sendTestMessage() {
    _watch.sendMessage({'itsa me': 'Mario'});
  }
}
