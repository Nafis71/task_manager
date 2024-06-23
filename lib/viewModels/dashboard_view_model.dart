import 'package:flutter/cupertino.dart';

class DashboardViewModel extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
