import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:studial/main.dart';
import 'package:studial/other/AppRoutes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IlanController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Text controller
  final aciklamaController = TextEditingController();

  // Observable variables
  final selectedVerilecekDers = ''.obs;
  final selectedAlinacakDers = ''.obs;

  final String yayinlanmaTarihi = DateFormat(
    'dd.MM.yyyy HH:mm',
  ).format(DateTime.now());

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

  // Error messages
  final verilecekDersError = ''.obs;
  final alinacakDersError = ''.obs;

  // Ders listesi
  final List<String> dersler = [
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

  @override
  void onClose() {
    aciklamaController.dispose();
    super.onClose();
  }

  // Verilecek ders seçimi
  void setVerilecekDers(String ders) {
    selectedVerilecekDers.value = ders;
    verilecekDersError.value = '';

    // Aynı ders seçilirse uyarı
    if (selectedAlinacakDers.value == ders) {
      Get.snackbar(
        'Uyarı',
        'Aynı dersi hem veremez hem de alamazsınız!',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.warning_rounded, color: Colors.white),
      );
      selectedAlinacakDers.value = '';
    }
  }

  // Alınacak ders seçimi
  void setAlinacakDers(String ders) {
    selectedAlinacakDers.value = ders;
    alinacakDersError.value = '';

    // Aynı ders seçilirse uyarı
    if (selectedVerilecekDers.value == ders) {
      Get.snackbar(
        'Uyarı',
        'Aynı dersi hem veremez hem de alamazsınız!',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        icon: const Icon(Icons.warning_rounded, color: Colors.white),
      );
      selectedVerilecekDers.value = '';
    }
  }

  // Form validasyonu
  bool _validateForm() {
    bool isValid = true;

    // Verilecek ders kontrolü
    if (selectedVerilecekDers.value.isEmpty) {
      verilecekDersError.value = 'Lütfen verebileceğiniz dersi seçiniz';
      isValid = false;
    } else {
      verilecekDersError.value = '';
    }

    // Alınacak ders kontrolü
    if (selectedAlinacakDers.value.isEmpty) {
      alinacakDersError.value = 'Lütfen almak istediğiniz dersi seçiniz';
      isValid = false;
    } else {
      alinacakDersError.value = '';
    }

    // Aynı ders kontrolü
    if (selectedVerilecekDers.value.isNotEmpty &&
        selectedAlinacakDers.value.isNotEmpty &&
        selectedVerilecekDers.value == selectedAlinacakDers.value) {
      verilecekDersError.value = 'Farklı dersler seçiniz';
      alinacakDersError.value = 'Farklı dersler seçiniz';
      isValid = false;
    }

    return isValid;
  }

  // İlan oluşturma
  Future<void> createIlan() async {
    if (!_validateForm()) {
      Get.snackbar(
        'Hata',
        'Lütfen gerekli alanları doldurunuz',
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.error_rounded, color: Colors.white),
      );
      return;
    }

    isLoading.value = true;

    try {
      await supabase.from('adverts').insert({
        'yayinlanma_tarihi': yayinlanmaTarihi,
        'verilecek_ders': selectedVerilecekDers.value,
        'alinacak_ders': selectedAlinacakDers.value,
        'user_id': supabase.auth.currentUser!.id,
        "user_name": displayName,
        "class_level": displayClass,
      });
      Get.snackbar(
        'Başarılı',
        'İlanınız başarıyla paylaşıldı',
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.error_rounded, color: Colors.white),
      );
      logger.i("Başarılı");
      Future.delayed(const Duration(seconds: 2), () {
        _clearForm();
        isLoading.value = false;
        Get.offAndToNamed(MobileRoutes.ANASAYFA);
      });
    } catch (e) {
      Get.snackbar(
        'Hata',
        'İlan paylaşılırken bir sorun oluştu',
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.error_rounded, color: Colors.white),
      );
      logger.e("İlan paylaşılırken hata: $e ");
    }
  }

  // Formu temizle
  void _clearForm() {
    selectedVerilecekDers.value = '';
    selectedAlinacakDers.value = '';
    aciklamaController.clear();
    verilecekDersError.value = '';
    alinacakDersError.value = '';
  }

  // Formu sıfırla (manuel)
  void resetForm() {
    _clearForm();
    Get.snackbar(
      'Bilgi',
      'Form temizlendi',
      backgroundColor: Colors.blue.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
