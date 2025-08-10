import 'package:get/get.dart';
import 'package:studial/mobile/pages/AnaSayfa/profile_page_controller.dart';

class ProfilePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfilePageController());
  }
}
