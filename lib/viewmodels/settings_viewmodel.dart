import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  bool _privateAccount = false;
  String _language = 'English';

  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;
  bool get privateAccount => _privateAccount;
  String get language => _language;

  void togglePushNotifications() {
    _pushNotificationsEnabled = !_pushNotificationsEnabled;
    notifyListeners();
  }

  void toggleEmailNotifications() {
    _emailNotificationsEnabled = !_emailNotificationsEnabled;
    notifyListeners();
  }

  void togglePrivacy() {
    _privateAccount = !_privateAccount;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }
}
