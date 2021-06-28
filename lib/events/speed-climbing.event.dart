import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class SpeedClimbingEvent implements BaseEvent {
  static const String type = 'speed-climbing';

  @override
  late String id;

  @override
  String title = 'Speed Climbing';

  @override
  String icon = '⚡️';

  @override
  late String subtitle;

  @override
  late DateTime timestamp;

  @override
  late int rating;

  late double time;

  SpeedClimbingEvent.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    time = data['meta']['time'];

    subtitle = "Your fastest time was ${time.toString()} seconds";
  }
}
