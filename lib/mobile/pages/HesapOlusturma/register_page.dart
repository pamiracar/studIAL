import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page_controller.dart';

class RegisterPage extends GetView<RegisterPageController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
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
                    width: MediaQuery.of(context).size.width - 270,
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
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
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
                        SizedBox(height: 20),
                        Obx(() {
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
                        SizedBox(height: 20),
                        Obx(() {
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
                              if (value != controller.passwordController.text) {
                                return "Lütfen şifrenizi doğru yazın";
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
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                controller: controller.nameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Lütfen bu alanı doldurun!";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hint: const Text("İsim ve Soyisim"),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1, // 50% genişlik
                              child: Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: DropdownMenu<String>(
                                    initialSelection:
                                        controller.selectedSinif.value,
                                    expandedInsets:
                                        EdgeInsets.zero, // Tam genişlik için
                                    onSelected: (String? newValue) {
                                      if (newValue != null) {
                                        controller.selectedSinif.value = newValue;
                                        debugPrint(
                                          controller.selectedSinif.value,
                                        );
                                      }
                                    },
                                    dropdownMenuEntries: controller.sinifListesi
                                        .map<DropdownMenuEntry<String>>((
                                          String value,
                                        ) {
                                          return DropdownMenuEntry<String>(
                                            value: value,
                                            label: value,
                                          );
                                        })
                                        .toList(),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: controller.hesapOlustur,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hesap Oluştur",
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
                            const Text("Bir hesabın var mı? "),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Text(
                                "Hesap Aç",
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
      ),
    );
  }
}
