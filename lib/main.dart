import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_binding.dart';
import 'package:studial/mobile/pages/Mesajlar/mesajlar.dart';
import 'package:studial/mobile/pages/Mesajlar/mesajlar_binding.dart';
import 'package:studial/other/AppRoutes.dart';
import 'package:studial/mobile/pages/Profil/profile_page.dart';
import 'package:studial/mobile/pages/Profil/profile_page_binding.dart';
import 'package:studial/mobile/pages/Giris/login_page.dart';
import 'package:studial/mobile/pages/Giris/login_page_binding.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page_binding.dart';
import 'package:studial/other/responsive.dart';
import 'package:studial/other/theme.dart';
import 'package:studial/web/pages/HomeWeb/home_web_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(url: "https://uzgblabjbfztgaszafeb.supabase.co", anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV6Z2JsYWJqYmZ6dGdhc3phZmViIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ0NjI1MjAsImV4cCI6MjA3MDAzODUyMH0.Snouvz-2_w4vyYZpw2RWuPTPtJOC3l-UkDgikjvafxU");
  WidgetsFlutterBinding.ensureInitialized();
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
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          getPages: [
            GetPage(name: MobileRoutes.CHAT, page:() => ChatPage(), binding: ChatPageBinding()),
            GetPage(name: MobileRoutes.ANASAYFA, page:() => HomePage(), binding: AnasayfaBinding()),
            GetPage(name: MobileRoutes.PROFIL, page: () => ProfilePage(), binding: ProfilePageBinding()),
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
