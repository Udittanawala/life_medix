import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/user_controller.dart';
import 'package:life_medix_demo/views/home_screen.dart';
import 'package:life_medix_demo/views/sign_up_screen.dart';

import '../utils/app_util.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  String? _name, _email, _password, _cpass, _contact;
  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text("Login Page", style: TextStyle(color: Colors.black)),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/img2.jpg",
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20), // Removed top padding
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20), // Slight spacing for aesthetic
                    Text(
                      "Login Now !!!!",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.cyan.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: controller.emailController,
                      cursorColor: Colors.cyan.shade600,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.cyan.shade500,
                        ),
                        hintText: 'Enter Your G-mail',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Gmail Address',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.cyan.shade600),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.cyan.shade600),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.cyan.shade600,
                            width: 2,
                          ),
                        ),
                      ),
                      // validator: (email) {
                      //   if (email == null || email.isEmpty) {
                      //     return "Enter Email Address";
                      //   } else if (!AppUtil.isValidName(email)) {
                      //     return "Enter Valid Email Address";
                      //   }
                      //   return null;
                      // },
                      // onSaved: (email) {
                      //   _email = email;
                      // },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.passController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.cyan.shade500,
                        ),
                        hintText: 'Valid Password',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.cyan.shade600),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.cyan.shade600),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.cyan.shade600,
                            width: 2,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      // validator: (pass) {
                      //   if (pass == null || pass.isEmpty) {
                      //     return "Password can't be empty";
                      //   } else if (!AppUtil.isValidName(pass)) {
                      //     return "Enter Valid Password";
                      //   }
                      //   return null;
                      // },
                      // onSaved: (pass) {
                      //   _password = pass;
                      // },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade500,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Login Now',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print("Registration Done!");
                          }
                          String email = controller.emailController.text.trim();
                          String pass = controller.passController.text.trim();
                          controller.loginuser(email: email, pass: pass);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have an Account?",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(width: 0),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              "Sign Up!",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.cyan.shade800),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 08,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "  Login With ",
                            style: TextStyle(color: Colors.green.shade900),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 20, // Adjust size
                                  width: 20,
                                ),
                                Text(
                                  "Google",
                                  style: TextStyle(
                                    color: Colors.cyan.shade900,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20), // Space between logos
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/facebook.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Text(
                                  "Facebook",
                                  style: TextStyle(
                                    color: Colors.cyan.shade900,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20), // Space between logos
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/twitter.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Text(
                                  "Twitter",
                                  style: TextStyle(
                                    color: Colors.cyan.shade900,
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
