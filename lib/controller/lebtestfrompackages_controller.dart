import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/model/labtestpackage_model.dart';

class LabtestPackageController extends GetxController {
  LabtestPackageModel? labtestPackageModel;
  RxBool isLoaded = false.obs;

  // Method to fetch lab test packages
  Future<void> getlabtestPackages({required String test_id}) async {
    try {
      isLoaded.value = true;
      final url = Uri.parse(ConstantData.LABTESTPACKAGE_API);
      var response = await http.post(url, body: {
        "test_id": test_id,
      });

      if (response.statusCode == 200) {
        labtestPackageModel = labtestPackageModelFromJson(response.body);
      } else {
        log('Failed to load lab test packages');
      }
      isLoaded.value = false;
    } catch (e) {
      isLoaded.value = false;
      log(e.toString(), name: "PRODUCT ERROR");
    }
  }
}
