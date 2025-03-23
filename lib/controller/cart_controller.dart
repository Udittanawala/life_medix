import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/model/apply_coupon_model.dart';
import 'package:life_medix_demo/model/cart_model.dart';
import 'package:life_medix_demo/model/coupon_model.dart';
import 'package:life_medix_demo/model/product_model.dart';
import 'package:life_medix_demo/views/home_page.dart';
import 'package:life_medix_demo/views/home_screen.dart';
import '../generated/const_data.dart';

class CartController extends GetxController {
  PrefManager manager = PrefManager();
  CartModel? model;

  String pay_type = "COD";

  final focusNode = FocusNode();
  bool isApply = false;

  final couponController = TextEditingController();

  RxInt amount = 0.obs;
  RxDouble couponDiscount = 0.0.obs; // To hold the coupon discount
  RxDouble finalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  RxBool isLoadingCart = false.obs;
  Future<void> addToCart({required Product product}) async {
    try {
      isLoadingCart.value = true;
      final url = Uri.parse(ConstantData.ADDTOCART_API);
      var response = await http.post(
        url,
        body: {
          'uid': manager.getUserId(),
          'pid': product.subId,
          'pname': product.subName,
          'ppic': product.subImg1,
          'amount': product.subPrice,
          'total_amount': product.subPrice,
          'date': (DateFormat('dd-MM-yyyy').format(DateTime.now())).toString(),
          'time': (DateFormat('hh:mm a').format(DateTime.now())).toString(),
        },
      );
      if (response.statusCode == 200) {
        //log(response.body, name: "ADD TO CART");
        model = cartModelFromJson(response.body);
        isLoadingCart.value = false;
        calculateAmount();
        Get.snackbar("Added!!", "Product Added To Cart");
      }
    } catch (e) {
      log(e.toString(), name: 'ADD TO CART ERROR');
      isLoadingCart.value = false;
    }
  }

  RxBool isload = false.obs;
  Future<void> getCartData() async {
    isload.value = true;

    try {
      final url = Uri.parse(ConstantData.GETOERDER_API);

      var response = await http.post(url, body: {
        'uid': manager.getUserId(),
      });
      if (response.statusCode == 200) {
        isload.value = false;

        //log(response.body, name: "cart data");
        model = cartModelFromJson(response.body);
        calculateAmount();
        isLoadingCart.value = false;
      }
    } catch (e) {
      isload.value = false;

      log(e.toString());
    }
  }

  Future<void> updateQty({
    required String qty,
    required String id,
    required String amount,
  }) async {
    try {
      final url = Uri.parse(ConstantData.UPDATEOERDER_API);
      var response = await http.post(url, body: {
        'id': id,
        'uid': manager.getUserId(),
        'quantity': qty,
        'amount': amount,
      });

      if (response.statusCode == 200) {
        getCartData();
      }
    } catch (e) {
      log(e.toString(), name: "UPDATE QTY ERROR");
    }
  }

  Future<void> removeOrder({
    required String id,
  }) async {
    try {
      final url = Uri.parse(ConstantData.REMOVEOERDER_API);
      var response = await http.post(url, body: {
        'id': id,
      });

      if (response.statusCode == 200) {
        getCartData();
      }
    } catch (e) {
      log(e.toString(), name: "REMOVE ORDER ERROR");
    }
  }

  ApplyCouponModel? cModel;
  Future<void> applyCoupon() async {
    try {
      final url = Uri.parse(ConstantData.APPLY_COUPON_API);
      var response = await http.post(
        url,
        body: {'code': couponController.text.trim()},
      );

      if (response.statusCode == 200) {
        log(response.body, name: "APPLY COUPON");
        cModel = applyCouponModelFromJson(response.body);

        if (cModel!.status) {
          Get.snackbar("Applied", "Coupon Applied");
          couponDiscount.value = double.parse(cModel!.data[0].couValue);
          calculateAmount();
          isApply = true;
        } else {
          couponDiscount.value = 0;
          calculateAmount();
          Get.snackbar("Invalid", "Enter Valid Coupon Code");
          isApply = false;
        }
        focusNode.unfocus();
      }
    } catch (e) {
      log(e.toString(), name: "COUPON SERVER ERROR");
    }
  }

  void calculateAmount() {
    double deliveryFee = 199.0;
    double gst = 38.0;
    double handlingFee = 3.0;
    amount.value = 0;
    for (int i = 0; i < model!.order.length; i++) {
      amount.value += int.parse(model!.order[i].totalAmount);
    }
    finalAmount.value =
        amount.value + deliveryFee + gst + handlingFee - couponDiscount.value;
    // for (var order in model.order[]) {
    //   amount.value += int.parse(order.totalAmount);
    // }
  }

  void removeCoupon() {
    if (isApply) {
      couponDiscount.value = 0;
      calculateAmount();
      Get.snackbar("Removed", "Discount Has Removed");
      couponController.clear();
      isApply = false;
      focusNode.unfocus();
    }
  }

  Future<void> confirmOrder() async {
    try {
      final url = Uri.parse(ConstantData.CONFIRM_ORDER_API);
      var response = await http.post(
        url,
        body: {
          'payment_type': pay_type,
          'address': 'SURAT',
          'uid': manager.getUserId(),
        },
      );
      if (response.statusCode == 200) {
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      log(e.toString(), name: "CONFIRM ORDER ERROR");
    }
  }

  Future<void> OrderHistory() async {
    try {
      final url = Uri.parse(ConstantData.ORDER_HISTORY_API);
      var response = await http.post(
        url,
        body: {
          'uid': manager.getUserId(),
        },
      );
      if (response.statusCode == 200) {
        // Get.offAll(() => HomePage());
      }
    } catch (e) {
      log(e.toString(), name: "ORDER HISTORY....");
    }
  }
}

// void calculateFinalAmount() {
//   double deliveryFee = 199.0;
//   double gst = 38.0;
//   double handlingFee = 3.0;
//   finalAmount.value =
//       amount.value + deliveryFee + gst + handlingFee - couponDiscount.value;
// }

// void applyCoupon() {
//   // Here you would typically validate the coupon code and set the discount
//   // For demonstration, let's assume a fixed discount of ₹50 for any coupon
//   couponDiscount.value = 50; // Set the discount amount
//   calculateFinalAmount(); // Recalculate the final amount
//   Get.snackbar("Coupon Applied",
//       "You have received a discount of ₹${couponDiscount.value}");
// }
