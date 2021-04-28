import 'package:flutter/foundation.dart';

class EarableState extends ChangeNotifier {
  String name = "eSense-0414";

  void changeEarable(String name) {
    this.name = name;
    notifyListeners();
  }
}
