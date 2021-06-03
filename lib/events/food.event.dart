import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class Food implements BaseEvent {
  static const String type = 'food';

  @override
  late String id;

  @override
  String title = 'Food';

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  int calories = 0;
  String description = "";

  Food.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    calories = data['meta']?['calories'] ?? '3';
    description = data['meta']?['description'] ?? '';
  }
}
