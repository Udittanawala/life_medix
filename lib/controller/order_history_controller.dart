import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/generated/pref_manager.dart';
import '../generated/const_data.dart';
import '../model/cart_model.dart';

class OrderHistoryController extends GetxController {
  CartModel? cartModel;
  PrefManager manager = PrefManager(); // Holds the fetched cart model
  RxBool isLoaded = false.obs; // Observable for loading state

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    isLoaded.value = false; // Set loading state to false initially
    try {
      final uid = manager.getUserId(); // Replace with actual user ID
      final url = Uri.parse(ConstantData.ORDER_HISTORY_API);

      log("Fetching order history from: $url with uid: $uid");

      var response = await http
          .post(url, body: {'uid': uid}); // Send POST request with uid

      log("Response Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('order')) {
          cartModel = CartModel.fromJson(jsonResponse);
          isLoaded.value = true;
          update(); // Notify listeners
        } else {
          log("Error: 'order' key not found in JSON response.");
        }
      } else {
        log("Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error fetching order history: $e");
    } finally {
      isLoaded.value = true; // Ensure UI updates even on failure
    }
  }
}
