import 'package:life/services/events.service.dart';

class BoulderingService extends EventsService {
  BoulderingService() : super();

  setHighestGrade(String documentId, String grade) {
    firestore
        .collection('users')
        .doc(userId)
        .collection('events')
        .doc(documentId)
        .update({
      'meta': {'highestGrade': grade}
    });
  }
}
