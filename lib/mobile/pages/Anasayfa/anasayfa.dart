import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/widgets/filter_card.dart';
import 'package:studial/mobile/widgets/ilan_card.dart';
import 'package:studial/other/AppRoutes.dart';

class HomePage extends GetView<AnasayfaController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StudIAL", style: TextStyle(fontSize: 30)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: controller.refreshButton,
            icon: Icon(Icons.refresh, size: 25),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'profil') {
                Get.toNamed(MobileRoutes.PROFIL);
              } else if (value == 'mesajlar') {
                Get.toNamed(MobileRoutes.CHAT);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'profil', child: Text('Profil')),
              const PopupMenuItem(value: 'mesajlar', child: Text('Mesajlar')),
            ],
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [filterCard(), SizedBox(height: 20), IlanCard()]),
      ),
    );
  }
}
