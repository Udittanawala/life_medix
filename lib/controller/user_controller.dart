import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/model/user_model.dart';
import 'package:life_medix_demo/views/home_screen.dart';
import 'package:life_medix_demo/views/login_screen.dart';

class UserController extends GetxController {
  UserModel? model;
  PrefManager manager = PrefManager();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final contactController = TextEditingController();

  Future<void> registerUser() async {
    try {
      log("Register Called", name: "REGISTER");
      final url = Uri.parse(
          ConstantData.SERVER_ADDRESS + ConstantData.REGISTER_USER_API);
      var response = await http.post(url, body: {
        "username": nameController.text.trim(),
        "password": passController.text.trim(),
        "email": emailController.text.trim(),
        "phone": contactController.text.trim(),
      });

      if (response.statusCode == 200) {
        model = UserModel.fromJson(jsonDecode(response.body));
        log(response.body, name: "SERVER DATA");
        Get.offAll(() => Loginpage());
      }
    } catch (e) {
      log(e.toString(), name: "ERROR");
    }
  }

  Future<void> loginuser({required String email, required String pass}) async {
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.LOGIN_USER_API);
      var response = await http.post(url, body: {
        "user_email": email,
        "user_pass": pass,
      });

      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"].toString() == "true") {
        model = UserModel.fromJson(jsonDecode(response.body));
        log(response.body, name: "SERVER DATA");

        manager.spAddUser(
          email: email,
          contact: model!.user.userContect,
          name: model!.user.userName,
          uid: model!.user.userId,
        );
        Get.snackbar("Login", "Login Success");
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Incorrect", "Please Check Email or Password");
      }
    } catch (e) {
      log(e.toString(), name: "ERROR");
    }
  }

  Future<void> checkIsLogin() async {
    bool value = manager.isLogin();
    if (value) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => Loginpage());
    }
  }
}
