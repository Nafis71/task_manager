import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityChecker extends ChangeNotifier {
  bool _isDeviceConnected = true;
  late StreamSubscription<InternetConnectionStatus> subscription;
  bool _isDisposed = false;
  bool get isDeviceConnected => _isDeviceConnected;

  Future<void> initConnectivityChecker() async {
    subscription = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _isDeviceConnected = true;
            notifyListeners();
            break;
          case InternetConnectionStatus.disconnected:
            _isDeviceConnected = false;
            notifyListeners();
            break;
        }
      },
    );
  }

  @override
  void dispose() {
    _isDisposed = true; // Set the disposal flag
    subscription.cancel(); // Cancel the subscription
    super.dispose(); // Call the superclass dispose method
  }

  Future<void> disableInternetConnectionChecker() async {
    if (_isDisposed) return; // Check if the instance is disposed
    await subscription.cancel();
  }
}
