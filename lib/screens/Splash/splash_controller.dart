import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      
      final isLoggedIn = await storage.read('isLoggedIn') ?? false;
      
      Get.offAllNamed(isLoggedIn ? '/home' : '/login');
    } catch (e) {
      // Handle any potential errors
      print('Error during splash screen: $e');
      Get.offAllNamed('/login');
    }
  }
}