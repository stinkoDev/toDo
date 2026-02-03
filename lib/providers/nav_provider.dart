import 'package:flutter/foundation.dart';

class NavProvider extends ChangeNotifier {
  int _selected = 1; // Default: home tab
  int get selected => _selected;

  void select(int index) {
    _selected = index;
    notifyListeners();
  }
}
