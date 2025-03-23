import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_medix_demo/generated/const_data.dart';
import '../controller/coupon_controller.dart';
import '../coupon_ui/coupon_ui.dart';

class OffersPage extends StatelessWidget {
  final CouponController couponController = Get.put(CouponController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade600,
        title: Text('Offers'),
      ),
      body: Obx(() {
        if (!couponController.isLoaded.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (couponController.couponModel?.data == null ||
            couponController.couponModel!.data.isEmpty) {
          return Center(child: Text("No coupons available."));
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: couponController.couponModel!.data.length,
          itemBuilder: (context, index) {
            var coupon = couponController.couponModel!.data[index];
            return CoupenUI(
              couponCode: coupon.couCode,
              couponDiscount: coupon.couValue,
              couponDescription: coupon.couTitle,
              couponImage: ConstantData.SERVER_ADDRESS_IMAGE +
                  coupon.couImg, // Ensure a valid string
            );
          },
        );
      }),
    );
  }
}
