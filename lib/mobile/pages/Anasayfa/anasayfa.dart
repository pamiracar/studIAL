import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';
import 'package:studial/mobile/pages/Profil/profile_page_controller.dart';
import 'package:studial/mobile/widgets/appBar_page_name.dart';
import 'package:studial/mobile/widgets/filter_card.dart';
import 'package:studial/mobile/widgets/ilan_card.dart';
import 'package:studial/other/AppRoutes.dart';

class HomePage extends GetView<AnasayfaController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            AppbarPageName(name: "StudIAL")
          ],
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.surfaceVariant.withOpacity(0.3)
                  : colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: isDark
                  ? colorScheme.surfaceVariant.withOpacity(0.3)
                  : colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              elevation: 8,
              color: colorScheme.surface,
              shadowColor: colorScheme.shadow.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              onSelected: (value) {
                if (value == 'profil') {
                  Get.toNamed(MobileRoutes.PROFIL);
                } else if (value == 'mesajlar') {
                  Get.toNamed(MobileRoutes.CHAT);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'profil',
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Profil',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'mesajlar',
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Mesajlar',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(
                          isDark ? 0.3 : 0.1,
                        ),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                          backgroundColor: colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'İlanlar yükleniyor...',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Hata durumu
        if (controller.error.value != null) {
          return Center(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(isDark ? 0.3 : 0.1),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red.shade400,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bir hata oluştu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lütfen internet bağlantınızı kontrol edip tekrar deneyin!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => controller.refreshProfile(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: isDark ? 4 : 2,
                    ),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text(
                      'Tekrar Dene',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refreshProfile(),
          color: colorScheme.primary,
          backgroundColor: colorScheme.surface,
          strokeWidth: 3,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ana başlık bölümü
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              colorScheme.primaryContainer.withOpacity(0.3),
                              colorScheme.secondaryContainer.withOpacity(0.2),
                            ]
                          : [
                              colorScheme.primaryContainer.withOpacity(0.1),
                              colorScheme.secondaryContainer.withOpacity(0.05),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(
                        isDark ? 0.3 : 0.1,
                      ),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(
                                isDark ? 0.2 : 0.1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.school_rounded,
                              color: colorScheme.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ders İlanları',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Ders vermek veya almak için ilanları inceleyin',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Filter başlık ve card
                Row(
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Filtrele',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                filterCard(),

                const SizedBox(height: 32),

                // İlanlar başlığı
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.article_rounded,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Aktif İlanlar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer.withOpacity(
                          isDark ? 0.3 : 0.5,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Obx(() {
                            return Text(
                             "${ controller.ilanSayisi.value} ilan",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,

                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Obx(() {
                  return Column(
                    children: [
                      IlanCard(
                        isim: controller.displayName,
                        yayinlanmaTarihi: controller.yayinlanmaTarihi,
                        vermekIstedigiDers: controller.verilecekDers.value,
                        karsilikDers: controller.alinacakDers.value,
                        sinif: controller.displayClass,
                      ),
                      IlanCard(
                        isim: controller.displayName,
                        yayinlanmaTarihi: controller.yayinlanmaTarihi,
                        vermekIstedigiDers: controller.verilecekDers.value,
                        karsilikDers: controller.alinacakDers.value,
                        sinif: controller.displayClass,
                      ),
                    ],
                  );
                }),

                // Bottom padding
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      }),
    );
  }
}
