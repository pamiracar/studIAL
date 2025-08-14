import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnasayfaController extends GetxController {
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
    "Fransızca - Yabancı Dil",
    "Felsefe",
    "Din Kültürü ve Ahlak Bilgisi",
  ];
  final RxString verilecekDers = "Matematik".obs;
  final RxString alinacakDers = "Coğrafya".obs;
  final String yayinlanmaTarihi = DateFormat(
    'dd.MM.yyyy HH:mm',
  ).format(DateTime.now());

  void refreshButton() {}

  void moreVerIcon() {}
  final supabase = Supabase.instance.client;

  var userName = Rxn<String>();
  var userClass = Rxn<String>();
  var createdAt = Rxn<DateTime>();
  var isLoading = false.obs;
  var error = Rxn<String>();

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      error.value = null;

      // Kullanıcının oturum açtığını kontrol et
      final user = supabase.auth.currentUser;
      if (user == null) {
        error.value = "Kullanıcı oturum açmamış";
        return;
      }

      print("User ID: ${user.id}"); // Debug için

      final response = await supabase
          .from('profiles')
          .select('name, class_level, created_at') // created_at eklendi
          .eq('id', user.id)
          .single();

      print("Response: $response"); // Debug için

      // Veri kontrolü
      if (response['name'] != null) {
        userName.value = response['name'].toString();
      } else {
        print("Name field is null in database");
      }

      if (response['class_level'] != null) {
        userClass.value = response['class_level'].toString();
      } else {
        print("Class_level field is null in database");
      }

      if (response['created_at'] != null) {
        createdAt.value = DateTime.parse(response['created_at']);
      } else {
        print("Created_at field is null in database");
      }
    } on PostgrestException catch (e) {
      error.value = "Veritabanı hatası: ${e.message}";
      print("PostgreSQL Error: ${e.message}");
      print("Error details: ${e.details}");
      print("Error hint: ${e.hint}");
    } catch (e) {
      error.value = "Genel hata: $e";
      print("General Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String get displayName => userName.value ?? "İsim yok";
  String get displayClass => userClass.value ?? "Sınıf yok";

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
}
