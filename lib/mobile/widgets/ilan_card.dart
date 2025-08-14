import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';

class IlanCard extends GetView<AnasayfaController> {
  const IlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.displayName),
                  Text(controller.yayinlanmaTarihi),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
