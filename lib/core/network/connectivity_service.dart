import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late bool isConnected;
  // Constructor
  ConnectivityService() {
    // Initial check for connectivity
    _checkInitialConnectivity();
  }

  void _checkInitialConnectivity() async {
    await _connectivity
        .checkConnectivity()
        .then((value) => _updateConnectionStatus(value));
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected = result != ConnectivityResult.none;
    debugPrint("Initial Connectivity: $isConnected");
  }

  StreamSubscription<ConnectivityResult> startConnectvityCheckerStream() {
    return _connectivity.onConnectivityChanged.listen((event) {
      debugPrint(event.toString());
      isConnected = event != ConnectivityResult.none;
    });
  }
}
