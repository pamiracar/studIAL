// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studial/mobile/pages/Anasayfa/anasayfa_controller.dart';

class filterCard extends GetView<AnasayfaController> {
  const filterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: colorScheme.primary.withOpacity(isDark ? 0.3 : 0.15),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter başlığı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(isDark ? 0.2 : 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.tune_rounded,
                                color: colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                "Filtrele",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Filtreleri temizle
                          controller.selectedDers.value = 'Tümü';
                          controller.selectedSinif.value = 'Tümü';
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: Icon(
                          Icons.clear_all_rounded,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        label: Text(
                          'Temizle',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

            const SizedBox(height: 20),

            // Dropdown'lar - Responsive
            LayoutBuilder(
              builder: (context, constraints) {
                // Küçük ekranlar için column layout
                if (constraints.maxWidth < 400) {
                  return Column(
                    children: [
                      _buildDropdownSection(
                        context: context,
                        label: 'Ders',
                        icon: Icons.book_rounded,
                        color: colorScheme.primary,
                        value: controller.selectedDers,
                        items: controller.dersListesi,
                        isDark: isDark,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdownSection(
                        context: context,
                        label: 'Sınıf',
                        icon: Icons.school_rounded,
                        color: isDark
                          ? colorScheme.secondary
                          : colorScheme.secondary,
                        value: controller.selectedSinif,
                        items: controller.sinifListesi,
                        isDark: isDark,
                      ),
                    ],
                  );
                }
                // Büyük ekranlar için row layout
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildDropdownSection(
                          context: context,
                          label: 'Ders',
                          icon: Icons.book_rounded,
                          color: colorScheme.primary,
                          value: controller.selectedDers,
                          items: controller.dersListesi,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        flex: 1,
                        child: _buildDropdownSection(
                          context: context,
                          label: 'Sınıf',
                          icon: Icons.school_rounded,
                          color: isDark
                            ? colorScheme.secondary
                            : colorScheme.secondary,
                          value: controller.selectedSinif,
                          items: controller.sinifListesi,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Aktif filtreler göstergesi
            Obx(() {
              final hasActiveFilters = controller.selectedDers.value != 'Tümü' ||
                                    controller.selectedSinif.value != 'Tümü';

              if (!hasActiveFilters) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Aktif Filtreler',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (controller.selectedDers.value != 'Tümü')
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _buildFilterChip(
                              context,
                              label: controller.selectedDers.value,
                              icon: Icons.book_rounded,
                              color: colorScheme.primary,
                              onRemove: () => controller.selectedDers.value = 'Tümü',
                            ),
                          ),
                        if (controller.selectedSinif.value != 'Tümü')
                          _buildFilterChip(
                            context,
                            label: controller.selectedSinif.value,
                            icon: Icons.school_rounded,
                            color: isDark
                              ? colorScheme.secondary
                              : colorScheme.secondary,
                            onRemove: () => controller.selectedSinif.value = 'Tümü',
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSection({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required RxString value,
    required List<String> items,
    required bool isDark,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark
              ? colorScheme.surfaceVariant.withOpacity(0.3)
              : colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(isDark ? 0.3 : 0.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Obx(() => DropdownButtonFormField<String>(
              value: value.value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                prefixIcon: Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
              ),
              dropdownColor: colorScheme.surface,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
              isExpanded: true, // Overflow'u önler
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  value.value = newValue;
                }
              },
            )),
          ),
        ),
      ],
    );
  }



  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onRemove,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(isDark ? 0.4 : 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                size: 12,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
