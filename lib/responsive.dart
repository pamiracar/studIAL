import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:studial/mobile/pages/Giris/login_page.dart';
import 'package:studial/mobile/pages/Giris/login_page_controller.dart';
import 'package:studial/web/pages/HomeWeb/home_web_page.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context, constraints) {
      if (constraints.maxWidth <= 800) {
        Get.put(LoginPageController());
        return LoginPage();
      } else {
        return HomeWebPage();
      }
    },);
  }
}
