import 'package:get/get.dart';
import 'package:studial/mobile/pages/Chat/chat_page_controller.dart';

class ChatPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
