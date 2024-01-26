import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool isConnected = true;
  StreamSubscription<ConnectivityResult> startConnectvityCheckerStream() {
    return _connectivity.onConnectivityChanged.listen((event) {
      print(event.toString());
      isConnected = event != ConnectivityResult.none;
    });
  }
}
