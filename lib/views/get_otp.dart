// get_otp_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class GetOtpScreen extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  void _verifyOtp(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Assume OTP verification succeeds
    prefs.setBool('isLoggedIn', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _verifyOtp(context),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
