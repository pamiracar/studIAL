import 'package:get/get.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';

class ProfilePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProfilePageController(), permanent: true);
  }
}
