import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:studial/other/AppRoutes.dart';
import 'package:studial/services/auth_service.dart';

class LoginPageController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  RxBool isPasswordShow = false.obs;
  final auth = AuthService();

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
  }

  Future<void> girisYap() async {
    try {
      if (loginFormKey.currentState!.validate()) {
        final email = emailController.text;
        final password = passwordController.text;
        await auth.signInWithEmailAndPassword(email, password);
        debugPrint("Giriş yapıldı");
        Get.offAndToNamed(MobileRoutes.ANASAYFA);
        Get.snackbar(
          "Giriş İşlemi Başarılı",
          "Hesap açma işlemi başarıyla gerçekleştirildi",
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar("Hata", e.toString());
    }
  }
}
