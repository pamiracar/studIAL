import 'package:get/get.dart';
import 'package:studial/models/ilan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePageController extends GetxController {
  final supabase = Supabase.instance.client;

  var userName = Rxn<String>();
  var userClass = Rxn<String>();
  var createdAt = Rxn<DateTime>();
  var isLoading = false.obs;
  var error = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchAdverts();
  }

  List<Ilan> adverts = [];

  Future<void> fetchAdverts() async{
    try {
      isLoading.value = true;
      error.value = null;

      final user = supabase.auth.currentUser;

      final response = await supabase
        .from("adverts")
        .select()
        .eq("user_id", user!.id);

      adverts = (response as List)
        .map((e) => Ilan.fromJson(e as Map<String, dynamic>),)
        .toList();

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

  // Manuel yenileme için
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  // Getter'lar - UI'da kullanmak için
  String get displayName => userName.value ?? "İsim yok";
  String get displayClass => userClass.value ?? "Sınıf yok";
  String get displayCreatedAt {
    if (createdAt.value == null) return "Tarih yok";

    final date = createdAt.value!;
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }

  // Alternatif olarak tam tarih-saat gösterimi
  String get displayCreatedAtFull {
    if (createdAt.value == null) return "Tarih yok";

    final date = createdAt.value!;
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  // User bilgileri
  String? get userId => supabase.auth.currentUser?.id;
  String? get userMail => supabase.auth.currentUser?.email;
}
