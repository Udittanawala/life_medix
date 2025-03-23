// import 'dart:convert';
// import 'dart:developer';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:life_medix_demo/generated/const_data.dart';
// import 'package:life_medix_demo/generated/pref_manager.dart';
// import 'package:life_medix_demo/model/user_model.dart';
//
// class EditProfileController extends GetxController {
//   UserModel? userModel;
//   RxBool isLoaded = false.obs;
//
//   PrefManager manager = PrefManager();
//
//   // Method to edit user profile
//   Future<void> editProfileUser({
//     required String userName,
//     required String userEmail,
//     required String userPass,
//   }) async {
//     try {
//       isLoaded.value = true;
//
//       final url = Uri.parse(ConstantData.EDITPROFILE_API);
//       var response = await http.post(url, body: {
//         "user_id": manager.getUserId(),
//         "user_name": userName,
//         "user_pass": userPass,
//         "user_email": userEmail,
//         "user_img": "E",
//       });
//
//       log("Edit Profile Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         isLoaded.value = false;
//         //Map<String, dynamic> responseData = json.decode(response.body);
//         userModel = userModelFromJson(response.body);
//
//         if (userModel!.status == true) {
//           log("Profile Updated Successfully");
//         }
//       }
//     } catch (e) {
//       isLoaded.value = false;
//       log("Error updating profile: $e", name: "EDIT PROFILE ERROR");
//     }
//   }
// }
