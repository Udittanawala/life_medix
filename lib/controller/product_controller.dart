import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/generated/const_data.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/model/product_model.dart';
import 'package:life_medix_demo/model/related_product_model.dart';

class ProductController extends GetxController {
  String uid = "0";
  PrefManager manger = PrefManager();

  @override
  Future<void> onInit() async {
    _getUserId();
    TopSelling();
    super.onInit();
  }

  Future<void> _getUserId() async {
    uid = manger.getUserId();
  }

  ProductModel? productModel;
  RxBool isLoaded = false.obs;

  Future<void> getProductFromCatId({
    required String cat_id,
  }) async {
    try {
      isLoaded.value = true;
      final url = Uri.parse(ConstantData.PRODUCT_FROM_CAT_API);
      var response = await http.post(url, body: {
        "cat_id": cat_id,
        "uid": uid,
      });

      if (response.statusCode == 200) {
        //log(uid, name: "PRODUCT USER ID");
        productModel = productModelFromJson(response.body);
        isLoaded.value = false;
      }
    } catch (e) {
      isLoaded.value = false;
      log(e.toString(), name: "PRODUCT ERROR");
    }
  }

  RelatedProductModel? relatedProductModel;
  RxBool isRelatedLoad = false.obs;
  RxBool isTopsLoaded = false.obs;

  Future<void> getRelatedProduct({
    required String sub_id,
    required String cat_id,
  }) async {
    try {
      isRelatedLoad.value = true;
      final url = Uri.parse(ConstantData.REALTED_PRODUCT_API);
      var response = await http.post(url, body: {
        "sub_id": sub_id,
        "cat_id": cat_id,
      });

      if (response.statusCode == 200) {
        //log(response.body, name: "RELATED PRODUCT");
        isRelatedLoad.value = false;
        relatedProductModel = relatedProductModelFromJson(response.body);
      }
    } catch (e) {
      log(e.toString(), name: "RELATED SERVER ERROR");
      isRelatedLoad.value = false;
    }
  }

  Future<void> TopSelling() async {
    try {
      isTopsLoaded.value = true; // Set loading to true
      final url = Uri.parse(ConstantData.TOP_SELLING);

      var response = await http.post(url, body: {
        "uid": uid,
      });

      if (response.statusCode == 200) {
        productModel = productModelFromJson(response.body);
      } else {
        log('Failed to load top selling products: ${response.statusCode}',
            name: "TopSelling API Error");
      }
    } catch (e) {
      log(e.toString(), name: "TopSelling API Exception");
    } finally {
      isTopsLoaded.value = false;
    }
  }
}
