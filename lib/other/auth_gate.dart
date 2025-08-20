import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/pages/Giris/login_page.dart';
import 'package:studial/mobile/pages/Giris/login_page_controller.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGateMobile extends StatelessWidget {
  const AuthGateMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder:(context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator(),),);
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          Get.put(ProfilePageController(), permanent: true);
          Get.put(AnasayfaController());
          return HomePage();
        } else {
          Get.put(LoginPageController());
          return LoginPage();
        }
      },
    );
  }
}
