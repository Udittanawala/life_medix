import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/model/banner_model.dart';

class BannerController extends GetxController {
  BannerModel? bannerModel;

  @override
  void onInit() {
    getBanner();
  }

  RxBool isloaded = false.obs;

  Future<void> getBanner() async {
    isloaded.value = true;
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.BANNER_API);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        bannerModel = BannerModel.fromJson(jsonDecode(response.body));
        log(response.body, name: "BANNER SERVER DATA");

        isloaded.value = false;
        update();
      }
    } catch (e) {
      isloaded.value = false;
      log(e.toString(), name: "ERROR");
    }
  }
}
