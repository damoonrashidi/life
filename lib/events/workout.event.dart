import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class WorkoutEvent implements BaseEvent {
  static const String type = 'workout';

  @override
  late String id;

  @override
  String title = 'Workout';

  @override
  String icon = '🏋';

  @override
  late String subtitle;

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  int calories = 0;
  String description = "";

  WorkoutEvent.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    description = data['meta']?['description'] ?? 'no desc';

    subtitle = description;
  }
}
