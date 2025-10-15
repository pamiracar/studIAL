import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:studial/main.dart';
import 'package:studial/models/ilan.dart';
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
  var selectedSinif = 'Tümü'.obs;
  List<String> sinifListesi = [
    'Tümü',
    '9. Sınıf',
    '10. Sınıf',
    '11. Sınıf',
    '12. Sınıf',
  ];
  final RxInt ilanSayisi = 1.obs;
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

  @override
  void onInit() {
    super.onInit();
    fetchAdverts();
    fetchProfile();
    filterAdvert();
  }

  RxList filtered = [].obs;

  Future<void> filterAdvert() async {
    filtered.value = adverts.where((ilan) {
      final dersFilter =
          selectedDers.value == 'Tümü' ||
          ilan.verilecekDers == selectedDers.value;

      final sinifFilter =
          selectedSinif.value == 'Tümü' ||
          ilan.classLevel == selectedSinif.value;
      return dersFilter && sinifFilter;

    }).toList();

    update();
  }

  RxBool shrin = true.obs;
  List<Ilan> adverts = [];

  Future<void> fetchAdverts() async {
    try {
      isLoading.value = true;
      error.value = null;
      final user = supabase.auth.currentUser;

      final response = await supabase
          .from("adverts")
          .select()
          .order("yayinlanma_tarihi", ascending: false);
      adverts = (response as List)
          .map((item) => Ilan.fromJson(item as Map<String, dynamic>))
          .toList();
      ilanSayisi.value = adverts.length;
      filterAdvert();
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
    fetchAdverts();
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

  Future<Map<String, dynamic>?> getConversation(
    String currentUserId,
    String otherUserId,
  ) async {
    final data = await supabase
        .from('conversations')
        .select()
        .or(
          'and(user1_id.eq.$currentUserId,user2_id.eq.$otherUserId),' +
              'and(user1_id.eq.$otherUserId,user2_id.eq.$currentUserId)',
        )
        .maybeSingle();

    if (data == null || (data is List && data.isEmpty)) {
      // Conversation yok
      return null;
    } else {
      // Conversation var
      return data;
    }
  }

  Future<Map<String, dynamic>> createConversation(
    String currentUserId,
    String otherUserId,
  ) async {
    final data = await supabase.from('conversations').insert({
      'user1_id': supabase.auth.currentUser!.id,
      'user2_id': otherUserId,
      'created_at': DateTime.now().toIso8601String(),
    }).select();

    return (data as List).first as Map<String, dynamic>;
  }
}

//chat
