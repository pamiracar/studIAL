import 'package:flutter/material.dart';
import 'package:studial/auth_gate.dart';
import 'package:studial/web/pages/HomeWeb/home_web_page.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context, constraints) {
      if (constraints.maxWidth <= 800) {
        return AuthGateMobile();
      } else {
        return HomeWebPage();
      }
    },);
  }
}
