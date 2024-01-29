import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late bool isConnected;
  // Constructor
  ConnectivityService() {
    // Initial check for connectivity
    _checkInitialConnectivity();
  }

  void _checkInitialConnectivity() {
    _connectivity
        .checkConnectivity()
        .then((value) => _updateConnectionStatus(value));
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    isConnected = result != ConnectivityResult.none;
    print("Initial Connectivity: $isConnected");
  }

  StreamSubscription<ConnectivityResult> startConnectvityCheckerStream() {
    return _connectivity.onConnectivityChanged.listen((event) {
      print(event.toString());
      isConnected = event != ConnectivityResult.none;
    });
  }
}
