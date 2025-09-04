import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  bool _biometricsEnabled = true;

  bool get biometricsEnabled => _biometricsEnabled;

  void setBiometrics(bool value) {
    _biometricsEnabled = value;
    notifyListeners();
  }
}
