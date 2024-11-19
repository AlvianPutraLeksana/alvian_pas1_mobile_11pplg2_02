import 'package:screens/LoginApi/apilogin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_text_field.dart';

import '../../RegisterApi/apiregister_view.dart';

class LoginView extends StatelessWidget {
  final ApiloginControllerr apiloginControllerr =
      Get.put(ApiloginControllerr());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: usernameController,
                labelText: 'Username',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                labelText: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 30),
              _buildRegisterButton(),
              SizedBox(height: 20),
              _buildStatusMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      apiloginControllerr.loginStatus.value = 'All fields are required';
                    } else {
                      apiloginControllerr.loginUser(
                        usernameController.text,
                        passwordController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => RegisterView());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: Icon(
                    Icons.app_registration,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusMessage() {
    return Obx(() => Column(
        children: [
            Text(
                apiloginControllerr.loginStatus.value,
                style: TextStyle(
                    color: apiloginControllerr.loginStatus.value.contains('berhasil') 
                        ? Colors.green 
                        : Colors.red,
                    fontSize: 14,
                ),
                textAlign: TextAlign.center,
            ),
            if (apiloginControllerr.token.value.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        'Token: ${apiloginControllerr.token.value}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                    ),
                ),
        ],
    ));
  }
}
