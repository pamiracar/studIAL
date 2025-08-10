import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/AnaSayfa/profile_page_controller.dart';
import 'package:studial/services/auth_service.dart';
import 'package:studial/theme.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anasayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.refreshProfile(),
          ),
          IconButton(onPressed: AuthService().signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Obx(() {
        // Loading durumu
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Hata durumu
        if (controller.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 64),
                SizedBox(height: 16),
                Text(
                  controller.error.value!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshProfile(),
                  child: Text('Tekrar Dene'),
                ),
              ],
            ),
          );
        }

        // Normal durum
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassContainer(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('E-posta'),
                  subtitle: Text(controller.userMail ?? 'Email yok'),
                ),
              ),
              SizedBox(height: 8),
              GlassContainer(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Kullanıcı Adı'),
                  subtitle: Text(controller.displayName),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GlassContainer(
                      child: ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Kayıt Tarihi'),
                        subtitle: Text(controller.displayCreatedAt),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GlassContainer(
                      child: ListTile(
                        leading: Icon(Icons.school),
                        title: Text('Sınıf Seviyesi'),
                        subtitle: Text(controller.displayClass),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              const ListTile(
                title: Text("İlanlarım"),
                trailing: Icon(Icons.add_rounded),
              ),
              SizedBox(
                height: 90,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 300,
                        child: GlassContainer(
                          child: ListTile(
                            leading: Icon(Icons.menu_book_rounded),
                            title: Text('İlan'),
                            subtitle: Text("Örnek Küçük"),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        width: 300,
                        child: GlassContainer(
                          child: ListTile(
                            leading: Icon(Icons.menu_book_rounded),
                            title: Text('İlan'),
                            subtitle: Text("Örnek Küçük"),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        width: 300,
                        child: GlassContainer(
                          child: ListTile(
                            leading: Icon(Icons.menu_book_rounded),
                            title: Text('İlan'),
                            subtitle: Text("Örnek Küçük"),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        width: 300,
                        child: GlassContainer(
                          child: ListTile(
                            leading: Icon(Icons.menu_book_rounded),
                            title: Text('İlan'),
                            subtitle: Text("Örnek Küçük"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
