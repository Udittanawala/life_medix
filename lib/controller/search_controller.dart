import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/model/product_model.dart';
import '../generated/const_data.dart';

class serch_controller extends GetxController {
  RxBool isLoading = false.obs; // Indicates if the search is in progress
  RxList<Product> searchResults = <Product>[].obs; // Holds the search results

  Future<void> search(String searchQuery) async {
    isLoading.value = true; // Set loading state to true
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.SEARCH_API);
      var response = await http.post(url, body: {
        'search': searchQuery,
        'uid': '1', // Replace with actual user ID if needed
      });

      log('API Response: ${response.body}'); // Log the response for debugging

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status']) {
          searchResults.value = (data['data'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
        } else {
          searchResults.clear(); // Clear previous results if no data
        }
      } else {
        log('Error: ${response.statusCode}', name: "ERROR");
      }
    } catch (e) {
      log(e.toString(), name: "ERROR"); // Log any errors
    }
    isLoading.value = false; // Set loading state to false
  }
}
