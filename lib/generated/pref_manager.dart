import 'dart:developer';

import 'package:get/get.dart';
import 'package:life_medix_demo/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const_data.dart';

class PrefManager {
  static final _instance = PrefManager._internal();
  SharedPreferences? pref;
  Future<void> init() async {
    pref ??= await SharedPreferences.getInstance();
  }

  factory PrefManager() {
    return _instance;
  }
  PrefManager._internal();

  Future<void> spAddUser({
    required String email,
    required String contact,
    required String name,
    required String uid,
  }) async {
    try {
      await pref!.setBool(ConstantData.IS_LOGIN_SP, true);
      await pref!.setString(ConstantData.KEY_CONTACT_SP, contact);
      await pref!.setString(ConstantData.KEY_EMAIL_SP, email);
      await pref!.setString(ConstantData.KEY_NAME_SP, name);
      await pref!.setString(ConstantData.KEY_ID, uid);
    } catch (e) {
      log(e.toString(), name: "SP ERROR");
    }
  }

  bool isLogin() {
    bool value = pref!.getBool(ConstantData.IS_LOGIN_SP) ?? false;
    return value;
  }

  String getUserId() {
    String val = pref!.getString(ConstantData.KEY_ID) ?? "0";
    return val;
  }

  String getUserName() {
    return pref!.getString(ConstantData.KEY_NAME_SP) ?? "0";
  }

  String getUserContact() {
    return pref!.getString(ConstantData.KEY_CONTACT_SP) ?? "0";
  }

  String getUserEmail() {
    return pref!.getString(ConstantData.KEY_EMAIL_SP) ?? "0";
  }

  Future<void> logoutUser() async {
    await pref!.clear();
    Get.to(() => Loginpage());
  }
}
