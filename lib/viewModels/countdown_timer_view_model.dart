import 'package:flutter/foundation.dart';

class CountdownTimerViewModel extends ChangeNotifier {
  int _resendTimeLeft = 60;

  int get resendTimeLeft => _resendTimeLeft;

  void updateCountdown() {
    _resendTimeLeft--;
    notifyListeners();
  }

  void resetCountDown() {
    _resendTimeLeft = 60;
  }
}
