import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';
import 'package:studial/mobile/widgets/neon_container.dart';
import 'package:studial/services/auth_service.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil", style: TextStyle(letterSpacing: 1),),
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
              NeonContainer(
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('E-posta'),
                  subtitle: Text(controller.userMail ?? 'Email yok'),
                ),
              ),
              SizedBox(height: 13),
              NeonContainer(
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Kullanıcı Adı'),
                  subtitle: Text(controller.displayName),
                ),
              ),
              SizedBox(height: 13),
              Row(
                children: [
                  Expanded(
                    child: NeonContainer(
                      child: ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Kayıt Tarihi'),
                        subtitle: Text(controller.displayCreatedAt),
                      ),
                    ),
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: NeonContainer(
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
              NeonContainer(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.menu_book_rounded),
                              title: Text('İlan'),
                              subtitle: Text("Örnek Küçük"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 300,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.menu_book_rounded),
                              title: Text('İlan'),
                              subtitle: Text("Örnek Küçük"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 300,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.menu_book_rounded),
                              title: Text('İlan'),
                              subtitle: Text("Örnek Küçük"),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 300,
                          child: Card(
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
