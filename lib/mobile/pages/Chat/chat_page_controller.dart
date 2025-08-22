import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final supabase = Supabase.instance.client;

  final conversationId = ''.obs; // aktif chat id
  var messages = <Map<String, dynamic>>[].obs; // mesajlar

  RealtimeChannel? _channel; // realtime channel

  void setConversation(String id) {
    conversationId.value = id;
    fetchMessages();
    listenNewMessages();
  }

  // Mesajları çek
  Future<void> fetchMessages() async {
    if (conversationId.value.isEmpty) return;

    final data = await supabase
        .from('messages')
        .select()
        .eq('conversation_id', conversationId.value)
        .order('created_at', ascending: true);

    if (data != null) {
      messages.value = List<Map<String, dynamic>>.from(data);
    }
  }

  // Yeni mesaj ekle
  Future<void> sendMessage(String userId, String text) async {
    if (conversationId.value.isEmpty) return;

    await supabase.from('messages').insert({
      'conversation_id': conversationId.value,
      'sender_id': userId,
      'content': text,
      'created_at': DateTime.now().toIso8601String(),
    });

    
  }

  void listenNewMessages() {
    if (conversationId.value.isEmpty) return;

    // Önce varsa eski channel'ı kapatalım
    _channel?.unsubscribe();

    _channel = supabase
        .channel('conversation_${conversationId.value}')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: "public",
          callback: (payload) {
            print(payload);
            final newMsg = payload.newRecord;
            messages.add(newMsg);
          },
        )
        .subscribe();
  }

  @override
  void onClose() {
    _channel?.unsubscribe();
    super.onClose();
  }
}
