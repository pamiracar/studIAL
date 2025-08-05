import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studial/AppRoutes.dart';
import 'package:studial/mobile/pages/AnaSayfa/home_page.dart';
import 'package:studial/mobile/pages/AnaSayfa/home_page_binding.dart';
import 'package:studial/mobile/pages/Giris/login_page.dart';
import 'package:studial/mobile/pages/Giris/login_page_binding.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page_binding.dart';
import 'package:studial/responsive.dart';
import 'package:studial/theme.dart';
import 'package:studial/web/pages/HomeWeb/home_web_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'studIAL',
          initialRoute: MobileRoutes.INITIAL,
          theme: StudialTheme.lightTheme,
          darkTheme: StudialTheme.darkTheme,
          themeMode: ThemeMode.system,
          getPages: [
            GetPage(name: MobileRoutes.ANASAYFA, page: () => HomePage(), binding: HomePageBinding()),
            GetPage(name: MobileRoutes.GIRIS, page: () => LoginPage(), binding: LoginPageBinding()),
            GetPage(name: MobileRoutes.OLUSTUR, page: () => RegisterPage(), binding: RegisterPageBinding()),
            GetPage(name: MobileRoutes.INITIAL, page: () => ResponsiveLayout()),
            GetPage(name: WebRoutes.HOME_W, page: () => HomeWebPage()),
          ],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
