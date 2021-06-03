import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String userId;

  EventsService() {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> eventsForDate(DateTime date) {
    var lower = DateTime(date.year, date.month, date.day, 0, 0, 0);
    var upper = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .where('timestamp', isGreaterThan: lower)
        .where('timestamp', isLessThan: upper)
        .snapshots();
  }

  addEvent(String type, Map<String, dynamic> meta) async {
    return firestore.collection('users').doc(userId).collection('events').add(
        {"type": type, "timestamp": DateTime.now(), "meta": meta, "rating": 0});
  }

  Future<void> setMeta(String documentId, Map<String, dynamic> meta) async {
    firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(documentId)
        .update({'meta': meta});
  }

  Future<void> setDateTime(String documentId, DateTime timestamp) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(documentId)
        .update({"timestamp": timestamp});
  }

  Future<void> rateEvent(String documentId, int rating) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(documentId)
        .update({'rating': rating});
  }
}
