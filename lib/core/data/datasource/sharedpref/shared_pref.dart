import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  readJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? "{}");
  }

  saveJson(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  removeJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}