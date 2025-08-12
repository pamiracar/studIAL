import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:studial/other/AppRoutes.dart';
import 'package:studial/mobile/pages/Giris/login_page_controller.dart';


class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top),
                const Text(
                  "studIAL",
                  style: TextStyle(letterSpacing: 15, fontSize: 40),
                ),
                const Text(
                  "Öğrenci Dayanışma Ağı",
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Lottie.asset(
                  "assets/animations/login.json",
                  width: MediaQuery.of(context).size.width - 100,
                ),
                const Text(
                  "Giriş Yap",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'E-posta boş olamaz';
                          }
                          if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          ).hasMatch(value)) {
                            return 'Geçerli bir e-posta adresi girin';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hint: const Text("E-posta"),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() {
                        return TextFormField(
                          controller: controller.passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Lütfen bu alanı doldurun!";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hint: const Text("Şifre"),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordShow.value =
                                    !controller.isPasswordShow.value;
                              },
                              icon: Obx(
                                () => controller.isPasswordShow.value
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                            ),
                          ),
                          obscureText: controller.isPasswordShow.value
                              ? false
                              : true,
                        );
                      }),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: controller.girisYap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Giriş Yap",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Bir hesabın yok mu? "),
                          GestureDetector(
                            onTap: () => Get.toNamed(MobileRoutes.OLUSTUR),
                            child: const Text(
                              "Hesap Oluştur",
                              style: TextStyle(color: Color(0xFF5A4FCF)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
