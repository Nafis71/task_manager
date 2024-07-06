import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityChecker extends ChangeNotifier {
  bool _isDeviceConnected = true;
  late StreamSubscription<InternetConnectionStatus> subscription;

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

  Future<void> disableInternetConnectionChecker() async {
    await subscription.cancel();
  }
}
