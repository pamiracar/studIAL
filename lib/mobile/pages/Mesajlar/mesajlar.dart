import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Mesajlar/mesajlar_controller.dart';
import 'package:studial/mobile/widgets/appBar_page_name.dart';

class ChatPage extends GetView<ChatPageController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            AppbarPageName(name: "Mesajlar")
          ],
        ),
      ),
    );
  }
}
