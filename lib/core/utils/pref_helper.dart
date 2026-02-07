import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String keyToken = "auth_token";

  static Future<void> saveToken(String? token) async {
    final pref = await SharedPreferences.getInstance();
    if (token == null) {
      //if token is null then return null but we cant setString with null
      await pref.remove(keyToken);
    } else {
      await pref.setString(keyToken, token);
    }
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(keyToken);
  }

  static Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(keyToken);
  }

  static Future<bool?> saveLogged(bool? isLogged) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setBool("isLogged", isLogged!);
  }

  static Future<bool?> isLogged() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool("isLogged");
  }

  static Future<bool> saveAppointmentCount({required int count})async{
    final pref = await SharedPreferences.getInstance();
    return pref.setInt("appCount", count);
  }
  static Future<int?> getAppointmentCount()async{
    final pref = await SharedPreferences.getInstance();
    return pref.getInt("appCount");
  }


}
