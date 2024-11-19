import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'apilogin_service.dart';

class ApiloginController extends GetxController {
  final storage = GetStorage();
  final ApiloginService apiService = ApiloginService();
  var isLoading = false.obs;
  var loginStatus = ''.obs;
  var token = ''.obs;

  Future<void> loginUser(String username, String password) async {
    try {
      isLoading(true);
      
      if (username.isEmpty || password.isEmpty) {
        throw 'Username dan password harus diisi';
      }

      final responseData = await apiService.login(username, password);
      
      if (responseData['status'] == true) {
        token.value = responseData['token'] ?? '';
        loginStatus.value = 'Login berhasil: ${responseData['message']}\nToken: ${token.value}';
        
        await storage.write('isLoggedIn', true);
        await storage.write('token', token.value);

        Get.snackbar(
          'Sukses',
          'Login berhasil!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed('/home');

      } else {
        loginStatus.value = 'Login gagal: ${responseData['message']}';
        Get.snackbar(
          'Error',
          responseData['message'] ?? 'Login gagal.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on Exception catch (e) {
      loginStatus.value = 'Login gagal: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan jaringan: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      loginStatus.value = 'Login gagal: $e';
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> logout() async {
    await storage.remove('isLoggedIn');
    await storage.remove('token');
    token.value = '';
    Get.offAllNamed('/login');
  }
}
