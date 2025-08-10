import 'package:get/get.dart';
import 'package:studial/mobile/pages/HesapOlusturma/register_page_controller.dart';

class RegisterPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterPageController());
  }
}
