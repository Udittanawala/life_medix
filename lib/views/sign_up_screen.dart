import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/controller/user_controller.dart';
import 'package:life_medix_demo/views/home_screen.dart';
import 'package:life_medix_demo/views/login_screen.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text("SignUp Page"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 23, top: 50),
              child: Text(
                "Welcome!",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.cyan.shade600,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Text(
                "Create your account SignUp Now!!!",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.cyan.shade900,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                "assets/images/back.jpg",
                height: 210,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.cyan.shade600,
                          ),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Name',
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
                        obscureText: false,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.cyan.shade600,
                          ),
                          hintText: 'Valid G-mail',
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
                        keyboardType: TextInputType.text,
                        obscureText: false,
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: controller.passController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.cyan.shade600,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.cyan.shade600),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.cyan.shade600),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.cyan.shade600,
                                width: 2,
                              ),
                            )),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0), // Space between fields
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password_rounded,
                            color: Colors.cyan.shade600,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Confirm Password',
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
                      ),
                      const SizedBox(height: 16.0), // Space between fields
                      TextField(
                        controller: controller.contactController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.cyan.shade600,
                          ),
                          hintText: 'Contact Number',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Contact Number',
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
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade500,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: controller.registerUser,
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Expanded(
                    flex: 2,
                    child: Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Loginpage(),
                          ));
                    },
                    child: Text(
                      "Login Now!",
                      style:
                          TextStyle(fontSize: 16, color: Colors.cyan.shade700),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class SignInCard extends StatelessWidget {
//   final userNamecontroller = TextEditingController();
//   final userEmailcontroller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 23),
//           child: Text(
//             "Welcome!",
//             style: TextStyle(
//                 fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 23),
//           child: Text(
//             "Create your account SignUp Now!!!",
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Card(
//               color: Colors.red.shade200, // Card color
//               elevation: 4.0, // Shadow effect
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20), // Rounded corners
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
//                       controller: userNamecontroller,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                         ),
//                         hintText: 'Your Name',
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         labelStyle: const TextStyle(color: Colors.black),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextField(
//                       controller: userEmailcontroller,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.email,
//                           color: Colors.white,
//                         ),
//                         hintText: 'Email',
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           borderSide: const BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         labelStyle: const TextStyle(color: Colors.black),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16.0),
//                     TextField(
//                       decoration: const InputDecoration(
//                         hintText: 'Password',
//                         prefixIcon: Icon(
//                           Icons.password,
//                           color: Colors.white,
//                         ),
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                       obscureText: true, // Hides password
//                     ),
//                     const SizedBox(height: 16.0), // Space between fields
//                     const TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.phone,
//                           color: Colors.white,
//                         ),
//                         hintText: 'Contact',
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                       obscureText: true, // Hides password
//                     ),
//                     const SizedBox(height: 16.0), // Space between fields
//                     const TextField(
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(
//                           Icons.password_sharp,
//                           color: Colors.white,
//                         ),
//                         hintText: 'Confirm Password',
//                         hintStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                     const SizedBox(height: 24.0),
//                     // ElevatedButton(
//                     //   onPressed: () {
//                     //     String Username = userNamecontroller.text.trim();
//                     //     String UserEmail = userEmailcontroller.text.trim();
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (context) => Bottomnavigation(
//                     //             username: Username, useremail: UserEmail),
//                     //       ),
//                     //     );
//                     //   },
//                     //   child: Text(
//                     //     'Sign In',
//                     //     style: TextStyle(
//                     //         color: Colors.red.shade200,
//                     //         fontWeight: FontWeight.bold,
//                     //         fontSize: 22),
//                     //   ),
//                     //   style: ElevatedButton.styleFrom(
//                     //     backgroundColor: Colors.white, // Button color
//                     //     padding: const EdgeInsets.symmetric(
//                     //         horizontal: 40.0, vertical: 12.0), // Button padding
//                     //   ),
//                     // ),
//                     FilledButton(onPressed: () {}, child: Text("Sign in"))
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Center(
//           child: Row(children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 60),
//               child: Text(
//                 "Already have an account ?",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.red.shade300,
//                 ),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomeScreen(),
//                       ));
//                 },
//                 child: Text(
//                   "Login Now!",
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ))
//           ]),
//         ),
//       ],
//     );
//   }
// }
