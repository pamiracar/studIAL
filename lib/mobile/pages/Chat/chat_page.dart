import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Chat/chat_page_controller.dart';
import 'package:studial/mobile/widgets/appBar_page_name.dart';
import 'package:studial/other/AppRoutes.dart';

class ChatPage extends GetView<ChatController> {
  final String conversationId;
  final String currentUserId;
  final String advertUserName;

  ChatPage({required this.conversationId, required this.currentUserId, required this.advertUserName, super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.setConversation(conversationId);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: () => Get.offAndToNamed(MobileRoutes.ANASAYFA),
        ),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Row(children: [AppbarPageName(name: advertUserName)]),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = msg['sender_id'] == currentUserId;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isMe ? Theme.of(context).colorScheme.primary : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        msg['content'],
                        style: TextStyle(
                          color: isMe ? Theme.of(context).colorScheme.background : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Theme.of(context).colorScheme.background,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Mesaj yaz...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).colorScheme.onSurfaceVariant,),
                  onPressed: () {
                    if (textController.text.trim().isEmpty) return;
                    controller.sendMessage(currentUserId, textController.text.trim());
                    textController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
