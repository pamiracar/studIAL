import 'package:get/get.dart';
import 'package:studial/services/auth_service.dart';

class AnasayfaController extends GetxController{
  void refreshButton(){
    AuthService().signOut();
  }

  void moreVerIcon(){

  }

  final RxString selectedDers = "Tümü".obs;

  List<String> dersListesi = [
    "Tümü",
    "Türk Dili ve Edebiyatı",
    "Matematik",
    "Geometri",
    "Fizik",
    "Kimya",
    "Biyoloji",
    "Coğrafya",
    "Tarih",
    "İngilizce - Yabancı Dil",
    "Almanca - Yabancı Dil",
    "Fransızca - Yabancı Dil"
    "Felsefe",
    "Din Kültürü ve Ahlak Bilgisi"
  ];
}
