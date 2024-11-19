import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'apiRegister_service.dart';

class RegisterController extends GetxController {
  final RegisterService apiService = RegisterService();
  var isLoading = false.obs;
  var registerStatus = ''.obs;

  Future<void> registerUser(
      String username, String password, String fullName, String email) async {
    try {
      isLoading(true);

      final responseData =
          await apiService.register(username, password, fullName, email);

      if (responseData['status'] == true) {
        registerStatus.value =
            'Registration successful: ${responseData['message']}';
        _showSnackbar('Success', 'Registration successful!', isError: false);
        Get.offNamed('/login');
      } else {
        registerStatus.value =
            'Registration failed: ${responseData['message']}';
        _showSnackbar('Error', responseData['message'] ?? 'Registration failed.');
      }
    } on Exception catch (e) {
      registerStatus.value = 'Registration failed: $e';
      _showSnackbar('Exception', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  void _showSnackbar(String title, String message, {bool isError = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }
}
