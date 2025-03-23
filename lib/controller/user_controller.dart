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

  RxBool isEditLoading = false.obs;
  Future<void> updateUser() async {
    isEditLoading.value = true;
    try {
      final url = Uri.parse(ConstantData.EDITPROFILE_API);

      var response = await http.post(
        url,
        body: {
          "user_id": manager.getUserId(),
          "user_name": nameController.text.trim(),
          "user_contect": contactController.text.trim(),
          "user_email": emailController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        isEditLoading.value = false;
        model = userModelFromJson(response.body);
        log(response.body, name: "SERVER DATA");
        if (model!.status == true) {
          manager.spAddUser(
            email: emailController.text.trim(),
            contact: model!.user.userContect,
            name: model!.user.userName,
            uid: manager.getUserId(),
          );
          Get.snackbar("Success", "Profile Updated Successfully");
          Get.offAll(() => HomeScreen());
        }
      }
    } catch (e) {
      isEditLoading.value = false;
      log(e.toString(), name: "SERVER ERROR");
    }
  }

  // Future<void> UpdateUser() async {
  //   try {
  //     final url =
  //         Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.EDITPROFILE_API);
  //
  //     var response = await http.post(url, body: {
  //       "user_id": manager.getUserId(),
  //       "user_name": nameController.text.trim(),
  //       "user_pass": passController.text.trim(),
  //       "user_email": emailController.text.trim(),
  //       "user_contect": contactController.text.trim(),
  //     });
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //
  //       if (data["status"].toString().toLowerCase() == "true") {
  //         // Only proceed if update was successful
  //         model = userModelFromJson(data);
  //
  //         manager.spAddUser(
  //           email: emailController.text.trim(),
  //           contact: contactController.text.trim(),
  //           name: nameController.text.trim(),
  //           uid: manager.getUserId(),
  //         );
  //
  //         Get.snackbar("Success", "Profile Updated Successfully");
  //         Get.offAll(() => HomeScreen()); // Navigate to home instead of login
  //       } else {
  //         Get.snackbar("Error", data["message"] ?? "Profile update failed");
  //       }
  //     } else {
  //       Get.snackbar("Error", "Server error: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     log(e.toString(), name: "ERROR");
  //     Get.snackbar("Error", "Something Went Wrong");
  //   }
  // }

// Future<void> UpdateUser() async {
  //   try {
  //     final url =
  //         Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.EDITPROFILE_API);
  //     var response = await http.post(url, body: {
  //       "user_id": manager.getUserId(),
  //       "user_name": nameController.text.trim(),
  //       "user_pass": passController.text.trim(),
  //       "user_email": emailController.text.trim(),
  //       "user_contect": contactController.text.trim(),
  //     });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       if (data["status"] == "true") {
  //         model = UserModel.fromJson(jsonDecode(response.body));
  //         Get.snackbar("Updated", "Profile Updated");
  //         Get.offAll(() => Loginpage());
  //       }
  //       Get.snackbar("Updated", "Profile Updated");
  //       Get.offAll(() => Loginpage());
  //       manager.spAddUser(
  //           email: emailController.text.trim(),
  //           contact: contactController.text.trim(),
  //           name: nameController.text.trim(),
  //           uid: manager.getUserId());
  //       log(response.body, name: "SERVER DATA");
  //     } else {
  //       Get.snackbar("ERROR", "Profile Not Updated");
  //     }
  //   } catch (e) {
  //     log(e.toString(), name: "ERROR");
  //     Get.snackbar("Error", "Something Went Wrong");
  //     Get.offAll(() => Loginpage());
  //   }
  // }
}
