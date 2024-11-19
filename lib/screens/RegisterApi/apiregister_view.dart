import 'package:screens/RegisterApi/apiregister_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController postController = Get.put(RegisterController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Create Account',
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
              SizedBox(height: 16),
              CustomTextField(
                controller: fullNameController,
                labelText: 'Full Name',
                prefixIcon: Icons.badge,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 30),
              _buildRegisterButton(),
              SizedBox(height: 16),
              _buildStatusMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () {
        if (usernameController.text.isEmpty ||
            passwordController.text.isEmpty ||
            fullNameController.text.isEmpty ||
            emailController.text.isEmpty) {
          postController.registerStatus.value = 'All fields are required';
        } else if (!GetUtils.isEmail(emailController.text)) {
          postController.registerStatus.value = 'Please enter a valid email';
        } else {
          postController.registerUser(
            usernameController.text,
            passwordController.text,
            fullNameController.text,
            emailController.text,
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
        'Register',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusMessage() {
    return Obx(() => Text(
          postController.registerStatus.value,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
