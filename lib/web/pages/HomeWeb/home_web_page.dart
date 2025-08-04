import 'package:flutter/material.dart';

class HomeWebPage extends StatefulWidget {
  const HomeWebPage({super.key});

  @override
  State<HomeWebPage> createState() => _HomeWebPageState();
}

class _HomeWebPageState extends State<HomeWebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("WEB View"),),
    );
  }
}
