import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_medix_demo/generated/const_data.dart';

class CoupenUI extends StatelessWidget {
  final String couponCode, couponDiscount, couponDescription, couponImage;

  CoupenUI({
    required this.couponCode,
    required this.couponDiscount,
    required this.couponDescription,
    required this.couponImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: CouponCard(
        height: 220,
        backgroundColor: Colors.cyan.shade50,
        clockwise: true,
        curvePosition: 130,
        curveRadius: 30,
        curveAxis: Axis.vertical,
        borderRadius: 12,
        firstChild: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade700, Colors.cyan.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.assetNetwork(
                  placeholder:
                      'assets/placeholder.png', // Add a local placeholder
                  image: couponImage.isNotEmpty
                      ? couponImage
                      : 'https://via.placeholder.com/100',
                  height: 30,
                  width: 30,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported,
                        size: 40, color: Colors.white);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$couponDiscount% OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                couponDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Coupon Code',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: couponCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied: $couponCode'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    couponCode,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.cyan.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap to Copy',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
