import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/%C4%B0lanEkleme/ilan_controller.dart';
import 'package:studial/mobile/widgets/ilan_card.dart';

class AddIlanPage extends GetView<IlanController> {
  const AddIlanPage({super.key});

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
        title: Text(
          'Yeni İlan',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık bölümü
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(isDark ? 0.3 : 0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(isDark ? 0.2 : 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add_circle_outline_rounded,
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
                            'İlan Oluştur',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ders takası için ilanınızı oluşturun',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurfaceVariant,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Verilecek ders
              Text(
                'Verebileceğim Ders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedVerilecekDers.value.isEmpty
                    ? null
                    : controller.selectedVerilecekDers.value,
                decoration: InputDecoration(
                  hintText: 'Ders seçiniz',
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.school_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  errorText: controller.verilecekDersError.value.isEmpty
                      ? null
                      : controller.verilecekDersError.value,
                ),
                dropdownColor: colorScheme.surface,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                items: controller.dersler.map((String ders) {
                  return DropdownMenuItem<String>(
                    value: ders,
                    child: Text(
                      ders,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.setVerilecekDers(newValue ?? '');
                },
              )),

              const SizedBox(height: 20),

              // Alınacak ders
              Text(
                'Almak İstediğim Ders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedAlinacakDers.value.isEmpty
                    ? null
                    : controller.selectedAlinacakDers.value,
                decoration: InputDecoration(
                  hintText: 'Ders seçiniz',
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.menu_book_rounded,
                    color: colorScheme.secondary,
                    size: 20,
                  ),
                  errorText: controller.alinacakDersError.value.isEmpty
                      ? null
                      : controller.alinacakDersError.value,
                ),
                dropdownColor: colorScheme.surface,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                items: controller.dersler.map((String ders) {
                  return DropdownMenuItem<String>(
                    value: ders,
                    child: Text(
                      ders,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  controller.setAlinacakDers(newValue ?? '');
                },
              )),

              const SizedBox(height: 20),

              // Önizleme kartı
              Obx(() {
                if (controller.selectedVerilecekDers.value.isNotEmpty ||
                    controller.selectedAlinacakDers.value.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İlan Önizleme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: IlanCard(isim: controller.displayName, yayinlanmaTarihi: controller.yayinlanmaTarihi, vermekIstedigiDers: controller.selectedVerilecekDers.value, karsilikDers: controller.selectedAlinacakDers.value, sinif: controller.displayClass, isIletisim: false, userID: "",)
                      ),
                      const SizedBox(height: 24),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),

              // Submit butonu
              Obx(() => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.createIlan(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: isDark ? 4 : 2,
                    shadowColor: colorScheme.primary.withOpacity(0.3),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'İlanı Oluştur',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              )),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
