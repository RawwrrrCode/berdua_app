import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get users => _db.collection('users');
  CollectionReference get couples => _db.collection('couples');
  CollectionReference get questions => _db.collection('questions');
  CollectionReference get inviteCodes => _db.collection('inviteCodes');
  CollectionReference get config => _db.collection('config');

  CollectionReference memories(String coupleId) =>
      _db.collection('couples').doc(coupleId).collection('memories');

  CollectionReference events(String coupleId) =>
      _db.collection('couples').doc(coupleId).collection('events');

  CollectionReference dailyAnswers(String coupleId) =>
      _db.collection('couples').doc(coupleId).collection('dailyAnswers');

  Future<void> runTransaction(
      Future<void> Function(Transaction tx) handler) async {
    await _db.runTransaction(handler);
  }
}
