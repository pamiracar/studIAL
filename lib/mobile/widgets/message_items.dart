import 'package:flutter/material.dart';

class MessageItemWidget extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String? time;
  final bool isUnread;
  final bool isOnline;
  final VoidCallback? onTap;

  const MessageItemWidget({
    Key? key,
    required this.name,
    required this.lastMessage,
    this.time,
    this.isUnread = false,
    this.isOnline = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread
              ? colorScheme.primary.withOpacity(0.3)
              : colorScheme.outline.withOpacity(0.2),
          width: isUnread ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(isDark ? 0.1 : 0.05),
            spreadRadius: 0,
            blurRadius: isUnread ? 15 : 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getColorFromName(name, isDark),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  _getInitials(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (time != null)
              Text(
                time!,
                style: TextStyle(
                  fontSize: 12,
                  color: isUnread
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  lastMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnread
                        ? colorScheme.onSurfaceVariant
                        : colorScheme.onSurfaceVariant.withOpacity(0.7),
                    fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isUnread)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // İsimden renk üretme fonksiyonu
  Color _getColorFromName(String name, bool isDark) {
    final colors = isDark
        ? [
            Colors.blue.shade700,
            Colors.green.shade700,
            Colors.orange.shade700,
            Colors.purple.shade700,
            Colors.red.shade700,
            Colors.teal.shade700,
            Colors.indigo.shade700,
            Colors.pink.shade700,
          ]
        : [
            Colors.blue,
            Colors.green,
            Colors.orange,
            Colors.purple,
            Colors.red,
            Colors.teal,
            Colors.indigo,
            Colors.pink,
          ];

    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = name.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return colors[hash.abs() % colors.length];
  }

  // İsimden baş harfleri alma fonksiyonu
  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    String initials = '';

    for (int i = 0; i < parts.length && i < 2; i++) {
      if (parts[i].isNotEmpty) {
        initials += parts[i][0].toUpperCase();
      }
    }

    return initials.isEmpty ? 'U' : initials;
  }
}
