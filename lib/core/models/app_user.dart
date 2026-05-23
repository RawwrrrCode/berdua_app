import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String initials;
  final String? coupleId;
  final bool isPremium;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Map<String, dynamic> preferences;
  final String locale;
  final String appVersion;

  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.initials,
    this.photoUrl,
    this.coupleId,
    this.isPremium = false,
    required this.createdAt,
    required this.updatedAt,
    this.preferences = const {
      'notifEnabled': true,
      'theme': 'warm',
    },
    this.locale = 'id-ID',
    this.appVersion = '0.1.0',
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      initials: data['initials'] ?? '',
      photoUrl: data['photoUrl'],
      coupleId: data['coupleId'],
      isPremium: data['isPremium'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      preferences: Map<String, dynamic>.from(data['preferences'] ?? {}),
      locale: data['locale'] ?? 'id-ID',
      appVersion: data['appVersion'] ?? '0.1.0',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'initials': initials,
      'photoUrl': photoUrl,
      'coupleId': coupleId,
      'isPremium': isPremium,
      'premiumExpiry': null,
      'premiumPurchasedAt': null,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'preferences': preferences,
      'locale': locale,
      'appVersion': appVersion,
      'fcmTokens': [],
    };
  }

  AppUser copyWith({
    String? displayName,
    String? photoUrl,
    String? initials,
    String? coupleId,
    bool? isPremium,
    Map<String, dynamic>? preferences,
  }) {
    return AppUser(
      uid: uid,
      email: email,
      displayName: displayName ?? this.displayName,
      initials: initials ?? this.initials,
      photoUrl: photoUrl ?? this.photoUrl,
      coupleId: coupleId ?? this.coupleId,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt,
      updatedAt: Timestamp.now(),
      preferences: preferences ?? this.preferences,
      locale: locale,
      appVersion: appVersion,
    );
  }

  static String generateInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
