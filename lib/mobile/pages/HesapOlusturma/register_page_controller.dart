import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();
  RxBool isPasswordShow = false.obs;

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
