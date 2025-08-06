import 'package:flutter/material.dart';
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
  Future<void> signUpWithProfile({
    required String email,
    required String password,
    required String name,
    required String gradeLevel,
  }) async {
    final supabase = Supabase.instance.client;
    // 1. Kullanıcıyı kaydet
    final signUpResponse = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    final userId = signUpResponse.user?.id;
    if (userId == null) {
      throw Exception('Kullanıcı oluşturulamadı');
    }
    // 2. Profil verisini yaz
    final response = await supabase.from('profiles').insert({
      'id': userId,
      'name': name,
      'grade_level': gradeLevel,
    });
    if (response.error != null) {
      throw Exception('Profil oluşturulamadı: ${response.error!.message}');
    }
    debugPrint('Kayıt ve profil başarıyla oluşturuldu!');
  }

  //Hesaptan çıkış yapma

  Future<void> signOut() async{
    await _supabase.auth.signOut();
  }
}
