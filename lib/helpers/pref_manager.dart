import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper class for Shared Preferences
class PrefManager {
  static PrefManager _mInstance = PrefManager._internal();

  PrefManager._internal();

  late SharedPreferences _pref;

  static Future<void> initialize() async {
    PrefManager._mInstance._pref = await SharedPreferences.getInstance();
  }

  static SharedPreferences getInstance() => _mInstance._pref;
}