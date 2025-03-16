import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/coupon_model.dart';
import '../generated/const_data.dart';

class CouponController extends GetxController {
  CouponModel? couponModel;
  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoupons();
  }

  Future<void> fetchCoupons() async {
    isLoaded.value = false;
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.COUPON_API);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        couponModel = CouponModel.fromJson(jsonDecode(response.body));
        isLoaded.value = true;
        update();
      } else {
        log("Error: ${response.statusCode}");
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoaded.value = true;
    }
  }
}
