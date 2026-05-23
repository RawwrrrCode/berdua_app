import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/auth/presentation/sign_in_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/presentation/anniversary_screen.dart';
import '../features/onboarding/presentation/invite_partner_screen.dart';
import '../features/onboarding/presentation/splash_screen.dart';
import '../features/onboarding/presentation/welcome_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final loc = state.uri.path;

      // Saat auth masih loading, jangan redirect
      if (authState.isLoading) return null;

      // Route yang tidak butuh auth
      final publicRoutes = ['/splash', '/welcome', '/sign-in', '/sign-up'];
      final isPublic = publicRoutes.any((r) => loc.startsWith(r));

      if (!isLoggedIn && !isPublic) return '/welcome';
      if (isLoggedIn && (loc == '/welcome' || loc == '/sign-in' || loc == '/sign-up')) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/onboarding/anniversary',
        builder: (context, state) => const AnniversaryScreen(),
      ),
      GoRoute(
        path: '/onboarding/invite-partner',
        builder: (context, state) => const InvitePartnerScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Halaman tidak ditemukan: ${state.error}'),
      ),
    ),
  );
});
