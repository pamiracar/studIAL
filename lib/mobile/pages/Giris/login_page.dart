import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
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
                    fontWeight: FontWeight.w300
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      EmailInputFieldFb3(inputController: controller.emailController),
                      SizedBox(height: 20,),
                      PasswordInputFieldFb3(inputController: controller.passwordController)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInputFieldFb3 extends StatelessWidget {
  final TextEditingController inputController;
  const EmailInputFieldFb3({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          filled: true,
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}

class PasswordInputFieldFb3 extends StatelessWidget {
  final TextEditingController inputController;
  const PasswordInputFieldFb3({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          filled: true,
          hintText: 'Enter your email',
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}

