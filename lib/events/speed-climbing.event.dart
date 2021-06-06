import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class SpeedClimbing implements BaseEvent {
  static const String type = 'speed-climbing';

  @override
  late String id;

  @override
  String title = 'Speed Climbing';

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  late double time;

  SpeedClimbing.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    time = double.parse(data['meta']['time']);
  }
}
