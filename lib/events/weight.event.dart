import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class Weight implements BaseEvent {
  static const String type = 'weight';

  @override
  late String id;

  @override
  String title = 'Weight';

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  late double weight;

  Weight.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    weight = data['meta']?['weight'];
  }
}
