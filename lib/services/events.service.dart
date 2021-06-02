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

  Future<void> rateEvent(String documentId, int rating) async {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(documentId)
        .update({'rating': rating});
  }
}
