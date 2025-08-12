import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';

class AnasayfaBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AnasayfaController());
  }
}
