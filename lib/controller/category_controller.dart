import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:life_medix_demo/model/category_model.dart';
import 'package:http/http.dart' as http;
import '../generated/const_data.dart';

class CategoryController extends GetxController {
  CategoryModel? categorymodel;


  @override
  void onInit() {
    getCategory();
  }

  RxBool isloaded = false.obs;

  Future<void> getCategory() async {
    isloaded.value = true;
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.CATEGORY_API);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        categorymodel = CategoryModel.fromJson(jsonDecode(response.body));
        //log(response.body, name: "SERVER DATA");
        isloaded.value = false;
        update();
      }
    } catch (e) {
      isloaded.value = false;
      log(e.toString(), name: "ERROR");
    }
  }
}
