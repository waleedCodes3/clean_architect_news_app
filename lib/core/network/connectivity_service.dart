import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool isConnected = false;
  // Constructor
  ConnectivityService() {
    // Initial check for connectivity
    _checkInitialConnectivity();
  }

  void _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
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
