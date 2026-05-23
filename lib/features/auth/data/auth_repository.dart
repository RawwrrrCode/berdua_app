import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/app_user.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/firestore_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final firestoreServiceProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    authService: ref.watch(authServiceProvider),
    firestoreService: ref.watch(firestoreServiceProvider),
  );
});

// Riverpod stream: current Firebase user (null = not logged in)
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// Riverpod: current AppUser doc from Firestore
final currentUserProvider = StreamProvider<AppUser?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) {
      if (user == null) return Stream.value(null);
      return ref
          .watch(firestoreServiceProvider)
          .users
          .doc(user.uid)
          .snapshots()
          .map((doc) => doc.exists ? AppUser.fromFirestore(doc) : null);
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

class AuthRepository {
  AuthRepository({
    required this.authService,
    required this.firestoreService,
  });

  final AuthService authService;
  final FirestoreService firestoreService;

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final credential = await authService.signUpWithEmail(
      email: email,
      password: password,
    );
    final user = credential.user!;

    // Update display name di Firebase Auth
    await user.updateDisplayName(displayName);

    // Buat user doc di Firestore
    final appUser = AppUser(
      uid: user.uid,
      email: email,
      displayName: displayName,
      initials: AppUser.generateInitials(displayName),
      coupleId: null,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    await firestoreService.users.doc(user.uid).set(appUser.toFirestore());
    return appUser;
  }

  Future<AppUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await authService.signInWithEmail(
      email: email,
      password: password,
    );
    final user = credential.user!;
    final doc = await firestoreService.users.doc(user.uid).get();
    if (!doc.exists) return null;
    return AppUser.fromFirestore(doc);
  }

  Future<AppUser?> signInWithGoogle() async {
    final credential = await authService.signInWithGoogle();
    if (credential == null) return null;

    final user = credential.user!;
    final docRef = firestoreService.users.doc(user.uid);
    final doc = await docRef.get();

    // Kalau user baru (first time Google sign-in), buat doc
    if (!doc.exists) {
      final displayName = user.displayName ?? 'Pengguna';
      final appUser = AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: displayName,
        initials: AppUser.generateInitials(displayName),
        photoUrl: user.photoURL,
        coupleId: null,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );
      await docRef.set(appUser.toFirestore());
      return appUser;
    }

    return AppUser.fromFirestore(doc);
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}
