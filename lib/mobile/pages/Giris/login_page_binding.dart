import 'package:get/get.dart';
import 'package:studial/mobile/pages/Giris/login_page_controller.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginPageController());
  }
}
