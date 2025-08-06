import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studial/AppRoutes.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page_controller.dart';
import 'package:studial/theme.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

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
                SizedBox(height: 20),
                Lottie.asset(
                  "assets/animations/register.json",
                  width: MediaQuery.of(context).size.width - 200,
                ),
                SizedBox(height: 20),

                const Text(
                  "Hesap Oluştur",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      GlassContainer(
                        child: TextFormField(
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

                          decoration: InputDecoration(
                            hint: const Text("E-posta"),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GlassContainer(
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Lütfen bu alanı doldurun!";
                              }
                              if (!RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}$',
                              ).hasMatch(value)) {
                                return 'Şifre en az 8 karakter olmalı, büyük harf, küçük harf,\nbir rakam ve bir özel karakter içermeli.';
                              }

                              return null;
                            },
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
                      ),
                      SizedBox(height: 20),
                      GlassContainer(
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.passwordConfirmController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Lütfen bu alanı doldurun!";
                              }
                              if (!RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}$',
                              ).hasMatch(value)) {
                                return 'Şifre en az 8 karakter olmalı, büyük harf, küçük harf,\nbir rakam ve bir özel karakter içermeli.';
                              }
                              if(value == controller.passwordController.value.toString()){
                                return "Lütfen şifrenizi tekrar yazın";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hint: const Text("Şifre Tekrar"),
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
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.registerFormKey.currentState!
                              .validate()) {
                          }
                        },
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
