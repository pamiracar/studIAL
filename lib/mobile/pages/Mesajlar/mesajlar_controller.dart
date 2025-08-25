import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/pages/Chat/chat_page.dart';
import 'package:studial/mobile/pages/Chat/chat_page_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPageControllerL extends GetxController {
  RxInt ry = 0.obs;
  final supabase = Supabase.instance.client;

  var userName = Rxn<String>();
  var userClass = Rxn<String>();
  var createdAt = Rxn<DateTime>();
  var isLoading = false.obs;
  var error = Rxn<String>();
  var conversations = <Map<String, dynamic>>[].obs;
  var isLoadingConversations = false.obs;

  // Karşı taraf isimlerini önbelleğe alalım
  final Map<String, String> otherNames = <String, String>{};

  RealtimeChannel? _convChannel;

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

  Future<void> fetchConversations() async {
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) return;

    try {
      isLoadingConversations.value = true;

      final data = await supabase
          .from('conversations')
          .select(
            'id, user1_id, user2_id, last_message, last_message_at, unread_by',
          )
          .or('user1_id.eq.${currentUser.id},user2_id.eq.${currentUser.id}')
          .order('last_message_at', ascending: false);

      debugPrint("Fetched conversations: $data");
      debugPrint("Current user ID: ${currentUser.id}");

      conversations.value = List<Map<String, dynamic>>.from(data);

      // İsimleri yükle ve bekle
      await _preloadOtherUserNames();

    } catch (e) {
      debugPrint("Error fetching conversations: $e");
    } finally {
      isLoadingConversations.value = false;
    }
  }

  Future<void> _preloadOtherUserNames() async {
    final currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId == null) return;

    // Eksik isim lazım olan diğer kullanıcı id'lerini topla
    final ids = <String>{};
    for (final conv in conversations) {
      final uid1 = conv['user1_id'] as String?;
      final uid2 = conv['user2_id'] as String?;

      if (uid1 == null || uid2 == null) continue;

      final otherId = uid1 == currentUserId ? uid2 : uid1;
      debugPrint("Processing conversation: user1=$uid1, user2=$uid2, other=$otherId, current=$currentUserId");

      // Her zaman fresh data için yükle (test amaçlı)
      ids.add(otherId);
    }

    debugPrint("IDs to fetch: $ids");

    if (ids.isEmpty) {
      debugPrint("No IDs to fetch names for");
      return;
    }

    try {
      debugPrint("Making database query for profiles with IDs: ${ids.toList()}");

      // Önce tüm profiles tablosunu kontrol edelim (debug için)
      final allProfiles = await supabase
          .from('profiles')
          .select('id, name')
          .limit(10);
      debugPrint("Sample profiles in database: $allProfiles");

      // Sonra spesifik ID'yi sorgulayalım
      final profiles = await supabase
          .from('profiles')
          .select('id, name')
          .inFilter('id', ids.toList());

      debugPrint("Raw profiles response from database: $profiles");
      debugPrint("Response type: ${profiles.runtimeType}");
      debugPrint("Response length: ${profiles.length}");

      // Eğer boşsa, tek tek ID'leri kontrol edelim
      if (profiles.isEmpty && ids.isNotEmpty) {
        debugPrint("No profiles found, checking individual IDs...");
        for (final id in ids) {
          final singleCheck = await supabase
              .from('profiles')
              .select('id, name')
              .eq('id', id);
          debugPrint("Single check for $id: $singleCheck");
        }
      }

      // Her profili detaylı logla
      for (int i = 0; i < profiles.length; i++) {
        final profile = profiles[i];
        debugPrint("Profile $i: $profile");
        debugPrint("  - ID: ${profile['id']} (${profile['id'].runtimeType})");
        debugPrint("  - Name: ${profile['name']} (${profile['name'].runtimeType})");
      }

      // Önce tüm ID'ler için default değer ata
      for (final id in ids) {
        otherNames[id] = 'Kullanıcı [Default]';
        debugPrint("Set default name for $id");
      }

      // Sonra gerçek isimleri ata
      for (final profile in profiles) {
        final id = profile['id'] as String?;
        final name = profile['name'] as String?;

        debugPrint("Processing profile: id=$id, name='$name'");

        if (id != null) {
          if (name != null && name.trim().isNotEmpty) {
            otherNames[id] = name.trim();
            debugPrint("✅ Set name for $id: '$name'");
          } else {
            otherNames[id] = 'Kullanıcı [No Name]';
            debugPrint("❌ No valid name for $id, using placeholder");
          }
        }
      }

      debugPrint("=== FINAL otherNames map ===");
      otherNames.forEach((key, value) {
        debugPrint("  $key => '$value'");
      });
      debugPrint("=============================");

      // UI'ı güncelle
      conversations.refresh();
      

    } catch (e) {
      debugPrint("❌ Error preloading names: $e");
      debugPrint("Error type: ${e.runtimeType}");
      // Hata durumunda varsayılan isimleri ata
      for (final id in ids) {
        otherNames[id] = 'Kullanıcı [Error]';
      }
    }
  }

  // Tek bir kullanıcının ismini yükle (acil durumlarda)
  Future<String> _fetchSingleUserName(String userId) async {
    try {
      final response = await supabase
          .from('profiles')
          .select('name')
          .eq('id', userId)
          .maybeSingle();

      if (response != null && response['name'] != null) {
        final name = (response['name'] as String).trim();
        if (name.isNotEmpty) {
          otherNames[userId] = name;
          return name;
        }
      }
    } catch (e) {
      debugPrint("Error fetching single user name for $userId: $e");
    }

    otherNames[userId] = 'Kullanıcı';
    return 'Kullanıcı';
  }

  // Okundu işaretle + navigasyon
  Future<void> openConversation(
    String conversationId, {
    required String otherUserName,
    required String otherUserId,
  }) async {
    final currentUserId = supabase.auth.currentUser!.id;

    // Okundu yap (unread_by'dan kendi id'ni sil)
    try {
      await supabase.rpc(
        'mark_conversation_read',
        params: {'p_conv_id': conversationId, 'p_user_id': currentUserId},
      );
    } catch (_) {}

    // Chat sayfasına git (route'unu kendine göre ayarla)
    Get.to(() {
      Get.put(ChatController());
      return ChatPage(
        conversationId: conversationId,
        currentUserId: currentUserId,
        advertUserName: otherUserName,
        advertUserId: otherUserId,
      );
    });
  }

  // Realtime: konuşma güncellendiğinde listeyi yenileyelim
  void _subscribeConversationsRealtime() {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return;

    _convChannel?.unsubscribe();
    _convChannel = supabase
        .channel('conversations_list_$uid')
        // user1 benim olan satır güncellenirse
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: "conversations",
          callback: (payload) async {
            debugPrint("Realtime update received: ${payload.newRecord}");
            await fetchConversations();
          },
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user1_id',
            value: uid,
          ),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: "conversations",
          callback: (payload) async {
            debugPrint("Realtime update received: ${payload.newRecord}");
            await fetchConversations();
          },
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user2_id',
            value: uid,
          ),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: "conversations",
          callback: (payload) async {
            debugPrint("Realtime insert received: ${payload.newRecord}");
            await fetchConversations();
          },
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user1_id',
            value: uid,
          ),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: "conversations",
          callback: (payload) async {
            debugPrint("Realtime insert received: ${payload.newRecord}");
            await fetchConversations();
          },
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user2_id',
            value: uid,
          ),
        )
        .subscribe();
  }

  // UI yardımcıları
  String otherUserIdOf(Map<String, dynamic> conv) {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return '';

    final uid1 = conv['user1_id'] as String?;
    final uid2 = conv['user2_id'] as String?;

    if (uid1 == null || uid2 == null) return '';

    return uid1 == uid ? uid2 : uid1;
  }

  String otherUserNameOf(Map<String, dynamic> conv) {
    final otherId = otherUserIdOf(conv);
    if (otherId.isEmpty) return 'Kullanıcı';

    // Önbellekte var mı kontrol et - sadece return et, asenkron işlem yapma
    return otherNames[otherId] ?? 'Kullanıcı';
  }

  bool isUnread(Map<String, dynamic> conv) {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return false;

    final list = (conv['unread_by'] as List?) ?? const [];
    return list.contains(uid);
  }

  // Önbelleği temizle (logout vb. durumlarda)
  void clearCache() {
    otherNames.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchConversations();
    _subscribeConversationsRealtime();
  }

  @override
  void onClose() {
    _convChannel?.unsubscribe();
    super.onClose();
  }
}
