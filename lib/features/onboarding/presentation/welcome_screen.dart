import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(Icons.photo_library_outlined,
                    size: 56, color: AppColors.primary),
              ),

              const SizedBox(height: 32),
              const Text(
                'Simpan setiap momen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              const Text(
                'Foto, rencana, dan catatan — semua di satu tempat yang cuma kalian punya.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const Spacer(),
TextButton(
  onPressed: () async {
    try {
      // Write test doc
      await FirebaseFirestore.instance
        .collection('test')
        .doc('connection')
        .set({
          'message': 'Halo Firebase!',
          'timestamp': FieldValue.serverTimestamp(),
        });

      // Read kembali
      final doc = await FirebaseFirestore.instance
        .collection('test')
        .doc('connection')
        .get();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Firebase connected! Data: ${doc.data()}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  },
  child: const Text('Test Firebase'),
),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/sign-in'),
                  child: const Text('Lanjut'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}