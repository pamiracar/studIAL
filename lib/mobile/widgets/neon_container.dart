import 'package:flutter/material.dart';
import 'package:studial/other/theme.dart';

class NeonContainer extends StatelessWidget {
  final Widget child;
  const NeonContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).cardColor,
            Theme.of(context).cardColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 0),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.1),
            blurRadius: 40,
            offset: const Offset(0, 0),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 1),
      ),
      child: child,
    );
  }
}
