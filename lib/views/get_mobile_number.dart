import 'package:flutter/material.dart';

import 'get_otp.dart';

class GetMobileNoPage extends StatelessWidget {
  final TextEditingController _mobileController = TextEditingController();

  void _generateOtp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GetOtpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Mobile Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _generateOtp(context),
              child: Text('Generate OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
