import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPageController extends GetxController{
  RxInt ry = 0.obs;
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
          .select('name') // created_at eklendi
          .eq('id', user.id)
          .single();

      print("Response: $response"); // Debug için

      // Veri kontrolü
      if (response['name'] != null) {
        userName.value = response['name'].toString();
      } else {
        print("Name field is null in database");
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

  // Manuel yenileme için
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  // Getter'lar - UI'da kullanmak için
  String get displayName => userName.value ?? "İsim yok";

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

}
