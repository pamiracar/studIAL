import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/global.dart';
import 'package:studial/services/auth_service.dart';

class RegisterPageController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  RxBool isPasswordShow = false.obs;
  RxString selectedSinif = "9.Sınıf".obs;
  List<String> sinifListesi = [
    'Hazırlık',
    '9.Sınıf',
    '10.Sınıf',
    '11.Sınıf',
    '12.Sınıf'
  ];
  final auth = AuthService();
  final global = Get.put(Global(), permanent: true);

  late final String email;
  late final String password;


  Future<void> hesapOlustur() async {
    if (registerFormKey.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;
      global.name = nameController.text;
      global.classLevel = selectedSinif.value.toString();
      auth.signUpOnly(email: email, password: password);
      Get.back();
      Get.snackbar("E-Posta Doğrulama", "Mail adresine yolladığımız link üzerinden doğrulamayı tamamla");
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
