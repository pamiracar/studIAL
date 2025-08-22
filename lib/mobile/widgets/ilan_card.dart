import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/pages/Chat/chat_page.dart';
import 'package:studial/mobile/pages/Chat/chat_page_binding.dart';
import 'package:studial/mobile/pages/Chat/chat_page_controller.dart';
import 'package:studial/mobile/pages/Mesajlar/mesajlar_controller.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';

class IlanCard extends GetView<AnasayfaController> {
  final String isim; // Kullanıcı adı
  final String yayinlanmaTarihi;
  final String vermekIstedigiDers;
  final String karsilikDers;
  final String sinif;
  final String userID;
  final bool isIletisim;

  const IlanCard({
    super.key,
    required this.isim,
    required this.yayinlanmaTarihi,
    required this.vermekIstedigiDers,
    required this.karsilikDers,
    required this.sinif,
    required this.isIletisim,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Theme-aware colors
    final primaryColor = colorScheme.primary;
    final secondaryColor = colorScheme.secondary;
    final surfaceColor = colorScheme.surface;
    final onSurfaceColor = colorScheme.onSurface;
    final onSurfaceVariant = colorScheme.onSurfaceVariant;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        elevation: isDark ? 4 : 2,
        shadowColor: colorScheme.shadow.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: surfaceColor,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header - Kullanıcı adı ve tarih
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: primaryColor.withOpacity(0.15),
                        child: Text(
                          isim.isNotEmpty ? isim[0].toUpperCase() : 'A',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isim,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: onSurfaceColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            yayinlanmaTarihi,
                            style: TextStyle(
                              fontSize: 12,
                              color: onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Aktif',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Ana ders bilgileri container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.primaryContainer.withOpacity(0.1)
                      : colorScheme.primaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: primaryColor.withOpacity(isDark ? 0.3 : 0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Vermek istediği ders
                    _buildDersInfo(
                      context: context,
                      icon: Icons.school_rounded,
                      iconColor: primaryColor,
                      iconBgColor: primaryColor.withOpacity(isDark ? 0.2 : 0.1),
                      title: "Vermek istediği ders",
                      subtitle: vermekIstedigiDers,
                      subtitleColor: primaryColor,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 16),

                    // Swap divider
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: onSurfaceVariant.withOpacity(0.3),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(
                              isDark ? 0.2 : 0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.swap_horiz_rounded,
                            color: Colors.orange.shade600,
                            size: 16,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: onSurfaceVariant.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Karşılık ders
                    _buildDersInfo(
                      context: context,
                      icon: Icons.auto_stories_rounded,
                      iconColor: Colors.orange.shade600,
                      iconBgColor: Colors.orange.withOpacity(
                        isDark ? 0.2 : 0.1,
                      ),
                      title: "Karşılığında almak istediği",
                      subtitle: karsilikDers,
                      subtitleColor: Colors.orange.shade600,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Alt kısım - Sınıf ve İletişim
              Row(
                children: [
                  // Sınıf bilgisi
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark
                            ? colorScheme.secondaryContainer.withOpacity(0.3)
                            : colorScheme.secondaryContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(
                                isDark ? 0.3 : 0.2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.class_rounded,
                              color: isDark
                                  ? colorScheme.onSecondaryContainer
                                  : secondaryColor,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sınıf",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  sinif,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: onSurfaceColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // İletişim butonu
                  if (isIletisim) ...[
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: userID == controller.userId
                            ? null
                            : () async {
                                // ID’leri al
                                final currentUserId = controller
                                    .userId!; // burayı login user ID ile değiştir
                                final ilanSahibiId =
                                    userID;
                                final ilanSahibiName = isim; // ilan kartındaki userId

                                // 1. Conversation var mı kontrol et
                                final convo = await controller.getConversation(
                                  currentUserId,
                                  ilanSahibiId,
                                );

                                String convoId;
                                if (convo != null) {
                                  convoId = convo['id'];
                                } else {
                                  final newConvo = await controller
                                      .createConversation(
                                        currentUserId,
                                        ilanSahibiId,
                                      );
                                  convoId = newConvo['id'];
                                }

                                // 2. ChatPage’e git
                                Get.to(
                                  () {
                                    Get.put(ChatController());
                                    return ChatPage(
                                    conversationId: convoId,
                                    currentUserId: currentUserId,
                                    advertUserName: ilanSahibiName,
                                  );
                                  },
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: isDark ? 4 : 2,
                        ),
                        icon: const Icon(Icons.chat_rounded, size: 16),
                        label: const Text(
                          'İletişim',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ] else
                    SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDersInfo({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required Color subtitleColor,
    required bool isDark,
  }) {
    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: subtitleColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
