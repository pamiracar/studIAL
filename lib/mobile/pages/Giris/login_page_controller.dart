import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:studial/AppRoutes.dart';
import 'package:studial/global.dart';
import 'package:studial/services/auth_service.dart';

class LoginPageController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  RxBool isPasswordShow = false.obs;
  final auth = AuthService();
  final global = Get.put(Global(), permanent: true);

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> girisYap() async {
    if (loginFormKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      await auth.signInWithEmailAndPassword(email, password);
      debugPrint("Giriş yapıldı");
      auth.createProfile(name: global.name, gradeLevel: global.classLevel);
      Get.offAndToNamed(MobileRoutes.ANASAYFA);
      Get.snackbar("Giriş İşlemi Başarılı", "Hesap açma işlemi başarıyla gerçekleştirildi", duration: Durations.medium4);
    }
  }
}
