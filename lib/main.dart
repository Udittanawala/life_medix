import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:life_medix_demo/generated/pref_manager.dart';
import 'package:life_medix_demo/views/cart_screen.dart';
import 'package:life_medix_demo/views/home_screen.dart';
import 'package:life_medix_demo/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Medix',
      //initialRoute: '/cart',
      // getPages: [
      //   GetPage(name: '/cart', page: () => SplashScreen()),
      //   // GetPage(name: '/home', page: () => HomeScreen()),
      // ],
      home: SplashScreen(),
    );
  }
}
