import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'screens/LoginApi/apilogin_controller.dart';
import 'screens/Splash/splash_controller.dart';
import 'screens/RegisterApi/apiregister_controller.dart';
import 'screens/LoginApi/apilogin_view.dart';
import 'screens/Splash/splash_screen.dart';
import 'screens/Profile/profile_controller.dart';
import 'screens/BottomNav/bottomnav.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        // Remove these since they're handled in route bindings
        // Get.put(SplashController());
        // Get.put(ApiloginControllerr());
      }),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
          binding: BindingsBuilder(() {
            Get.put(SplashController());
          }),
        ),
        GetPage(
          name: '/login',
          page: () => LoginView(),
          binding: BindingsBuilder(() {
            Get.put(ApiloginControllerr());
          }),
        ),
        GetPage(
          name: '/home',
          page: () => const BottomNav(),
          binding: BindingsBuilder(() {
            Get.put(RegisterController());
            Get.put(ProfileController());
          }),
        ),
      ],
    );
  }
}
