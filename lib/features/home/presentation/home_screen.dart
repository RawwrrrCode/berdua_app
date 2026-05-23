import 'package:flutter/material.dart';
import '../../../app/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text('Home Screen (TODO)'),
      ),
    );
  }
}