import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
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
        child: Column(children: [_filterCard()]),
      ),
    );
  }
}

class _filterCard extends GetView<AnasayfaController> {
  const _filterCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
  width: MediaQuery.of(context).size.width,
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    shadowColor: Colors.purple.withOpacity(0.3),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                "Filtrele",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.filter_alt,
                size: 28,
              ),
            ],
          ),
          const SizedBox(width: 50,),

          Container(
            height: 35,
            width: 2,
            decoration: BoxDecoration(
              color: Color(0xFF6A1B9A).withOpacity(0.5),
              borderRadius: BorderRadius.circular(1),
            ),
          ),

          const SizedBox(width: 20),
          Expanded(
            child: DropdownMenu<String>(
              initialSelection: controller.selectedDers.value,
              expandedInsets: EdgeInsets.zero,
              onSelected: (String? newValue) {
                if (newValue != null) {
                  controller.selectedDers.value = newValue;
                  debugPrint(controller.selectedDers.value);
                }
              },
              dropdownMenuEntries: controller.dersListesi
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: value,
                );
              }).toList(),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.purple.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}
