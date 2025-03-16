import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:life_medix_demo/controller/user_controller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 8), // Fade-in duration
        onEnd: () {
          controller.checkIsLogin();
        },
        builder: (context, opacityValue, child) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: opacityValue,
                  duration: Duration(seconds: 3),
                  child: Text(
                    'L I F E M E D I X',
                    style: TextStyle(
                      fontSize: 30, // Adjust font size
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RobotoMono', // Custom font
                      color: Colors.blue.shade800, // Adjust text color
                    ),
                  ),
                ),
                SizedBox(width: 0), // Space between text and animation
                AnimatedOpacity(
                  opacity: opacityValue,
                  duration: Duration(seconds: 1),
                  child: Lottie.asset(
                    'assets/images/Animation2.json', // Path to your Lottie file
                    fit: BoxFit.cover,
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
