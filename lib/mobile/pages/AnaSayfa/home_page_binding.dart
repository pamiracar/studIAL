import 'package:get/get.dart';
import 'package:studial/mobile/pages/AnaSayfa/home_page_controller.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomePageController());
  }
}
