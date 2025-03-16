import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:life_medix_demo/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:life_medix_demo/model/labtest_model.dart';
import '../generated/const_data.dart';

class LabtestController extends GetxController {
  LabtestModel? labtestModel;

  @override
  void onInit() {
    getLabtest();
  }

  RxBool isloaded = false.obs;

  Future<void> getLabtest() async {
    isloaded.value = true;
    try {
      final url =
          Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.LABTEST_API);

      var response = await http.get(url);
      if (response.statusCode == 200) {
        labtestModel = LabtestModel.fromJson(jsonDecode(response.body));
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

// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:life_medix_demo/generated/const_data.dart';
// import 'package:life_medix_demo/model/labtest_model.dart';
//
// class LabtestController extends GetxController {
//   LabtestModel? labtestModel;
//   RxBool isloaded = false.obs;
//
//   Future<void> Getlabtest() async {
//     isloaded.value = true;
//     try {
//       final url =
//           Uri.parse(ConstantData.SERVER_ADDRESS + ConstantData.LABTEST_API);
//
//       var response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         labtestModel = LabtestModel.fromJson(jsonDecode(response.body));
//         log(response.body, name: "SERVER DATA");
//         isloaded.value = false;
//       }
//     } catch (e) {
//       log(e.toString(), name: "ERROR");
//       isloaded.value = false;
//     }
//   }
// }
