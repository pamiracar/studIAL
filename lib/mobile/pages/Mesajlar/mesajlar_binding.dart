import 'package:get/get.dart';
import 'package:studial/mobile/pages/Mesajlar/mesajlar_controller.dart';

class ChatPageBindingL extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatPageControllerL());
  }

}
