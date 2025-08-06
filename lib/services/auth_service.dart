import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //Eposta ve şifre ile giriş yapma
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
  }

  //Eposta, şifre, isim,sınıf seviyesi ile hesap oluşturma

  Future<void> signUpOnly({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> createProfile({
    required String name,
    required String gradeLevel,
  }) async {
    final userId = _supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("Giriş yapılmamış. UID yok.");
    }

    final response = await _supabase.from('profiles').insert({
      'id': userId,
      'name': name,
      'class_level': gradeLevel,
    });

    if (response?.error != null) {
      throw Exception('Profil oluşturulamadı: ${response.error!.message}');
    }
  }

  //Hesaptan çıkış yapma

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
