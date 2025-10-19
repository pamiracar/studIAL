import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPageController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  RxBool isPasswordShow = false.obs;
  RxString selectedSinif = "9.Sınıf".obs;
  final supabaseAuth = Supabase.instance.client.auth;
  List<String> sinifListesi = [
    'Hazırlık',
    '9.Sınıf',
    '10.Sınıf',
    '11.Sınıf',
    '12.Sınıf',
  ];
  final auth = AuthService();

  late final String email;
  late final String password;
  late final String name;
  late final String sinif;
  late final bool emailAdressShow;
  RxBool emailShow = false.obs;
  Future<void> hesapOlustur() async {
    try {
      if (registerFormKey.currentState!.validate()) {
        email = emailController.text;
        password = passwordController.text;
        name = nameController.text;
        sinif = selectedSinif.value;
        emailAdressShow = emailShow.value;
        await auth.signUpOnly(email: email, password: password);
        await auth.createProfile(name: name, gradeLevel: sinif, emailShowValue: emailAdressShow);
        Get.back();
        Get.snackbar(
          "Hesap Oluşturuldu",
          "studIAL hesabınız başarıyla oluşturuldu",
        );
      }
    } catch (e) {
      Get.snackbar("Hata", e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
