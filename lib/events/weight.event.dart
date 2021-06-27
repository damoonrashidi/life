import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

class WeightEvent implements BaseEvent {
  static const String type = 'weight';

  @override
  late String id;

  @override
  String title = 'Weight';

  @override
  String icon = '⚖️';

  @override
  late String subtitle;

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  late double weight;

  WeightEvent.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    weight = data['meta']?['weight'];

    subtitle = "You weighed in at ${weight.toString()} kg";
  }
}
