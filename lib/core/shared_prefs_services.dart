import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  final String isSeenKey = "is_seen";
  final String isFirstRunKey = "first_run";

  Future<void> setIsSeen(bool isSeen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isSeenKey, isSeen);
  }

  Future<bool?> getIsSeenValue() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isSeenKey);
  }

  Future<void> setInstallationStatus(bool firstRun) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isFirstRunKey, firstRun);
  }

  Future<bool?> getInstallationStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isFirstRunKey);
  }
}
